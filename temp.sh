# Navigate to your main repository root
cd /path/to/your/auth-fhir/repo

# Update the submodule URLs in .gitmodules file
# Edit .gitmodules to point to your correct repository URLs
git config --file=.gitmodules submodule.fhir-server.url https://github.com/tthin09/fhir-server.git
git config --file=.gitmodules submodule.id-server.url https://github.com/tthin09/Keycloak-FHIR.git

# Sync the submodule configuration
git submodule sync

# Update the submodules
git submodule update --init --recursive