package ca.uhn.fhir.jpa.starter.extra.interceptor.auth;

import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.rest.server.servlet.ServletRequestDetails;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.core.annotation.Order;
import ca.uhn.fhir.rest.server.exceptions.ForbiddenOperationException;

import ca.uhn.fhir.jpa.starter.extra.service.types.ClientType;
import ca.uhn.fhir.jpa.starter.extra.service.util.PatientIdExtractor;


@Interceptor
@Component
@Order(1)
public class AfterAccessInterceptor {
    private static final Logger logger = LoggerFactory.getLogger(AfterAccessInterceptor.class);

    // If access by patient -> Check if that resource belongs to that patient
    @Hook(Pointcut.SERVER_OUTGOING_RESPONSE)
    public void afterResponse(ServletRequestDetails requestDetails, IBaseResource responseObject) {
        // If isn't accessed by patient -> Doesn't need to check anything, just return
        ClientType clientType = (ClientType) requestDetails.getAttribute("client_type");
        if (clientType != ClientType.PUBLIC) {
            return;
        }

        String patientIdInToken = (String) requestDetails.getAttribute("patient_id");
        logger.debug("Patient ID in token of AfterAccess: {}", patientIdInToken);

        if (responseObject instanceof Bundle bundle) {
            logger.debug("Querying for Bundle");
            String patientIdInPath = PatientIdExtractor.extractPatientIdFromPath(requestDetails.getCompleteUrl());

            if (patientIdInToken.equals(patientIdInPath)) {
                logger.debug("Found matching patient id in requestPath and token");
            }
            else {
                logger.warn("Querying for Bundle must have param 'patient=[id]' in path. Either query is missing path or patient id doesn't match with token. PatientId in path: {} | PatientId in token: {}", patientIdInPath, patientIdInToken);

                throw new ForbiddenOperationException("Querying for Bundle must have param 'patient=[id]' in path. Either query is missing path or patient id doesn't match with token");
            }
        } else if (responseObject instanceof Resource resource) {
            logger.debug("Querying for Resource");
            String patientIdInResource = extractPatientIdFromResource(resource);

            if (patientIdInResource.equals(patientIdInToken)) {
                logger.debug("On resource, patient ID is equal!");
            } else {
                throw new ForbiddenOperationException("This resource isn't belong to current patient");
            }
        }
    }

    private String extractPatientIdFromResource(Resource resource) {
        String patientId = "";
        // If the resource itself is a Patient
        if (resource instanceof Patient patient) {
            patientId = patient.getIdElement().getIdPart();
            logger.debug("Found patient_id (resource): {}", patient.getIdElement().getIdPart());
        }
        // Check for 'subject' reference (e.g., Observation, Encounter, Condition, etc.)
        else if (resource instanceof DomainResource domainResource) {
            // subject
            if (domainResource instanceof Observation obs && obs.hasSubject()) {
                Reference subjectRef = obs.getSubject();
                if ("Patient".equals(subjectRef.getReferenceElement().getResourceType())) {
                    patientId = subjectRef.getReferenceElement().getIdPart();
                    logger.debug("Found patient_id (subject): {}", subjectRef.getReferenceElement().getIdPart());
                }
            } else if (domainResource instanceof Encounter enc && enc.hasSubject()) {
                Reference subjectRef = enc.getSubject();
                if ("Patient".equals(subjectRef.getReferenceElement().getResourceType())) {
                    patientId = subjectRef.getReferenceElement().getIdPart();
                    logger.debug("Found patient_id (subject): {}", subjectRef.getReferenceElement().getIdPart());
                }
            } else if (domainResource instanceof Condition cond && cond.hasSubject()) {
                Reference subjectRef = cond.getSubject();
                if ("Patient".equals(subjectRef.getReferenceElement().getResourceType())) {
                    patientId = subjectRef.getReferenceElement().getIdPart();
                    logger.debug("Found patient_id (subject): {}", subjectRef.getReferenceElement().getIdPart());
                }
            } else if (domainResource instanceof Procedure proc && proc.hasSubject()) {
                Reference subjectRef = proc.getSubject();
                if ("Patient".equals(subjectRef.getReferenceElement().getResourceType())) {
                    patientId = subjectRef.getReferenceElement().getIdPart();
                    logger.debug("Found patient_id (subject): {}", subjectRef.getReferenceElement().getIdPart());
                }
            }
            // Add more resource types as needed
        }
        return patientId;
    }
}