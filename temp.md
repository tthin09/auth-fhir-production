Dạ anh Lỉnh em đang package cho trường hợp "phòng khám tải về là dùng luôn", thì em gặp vấn đề này:

⁠I can't push my docker image to docker hub because my account can only push 1 image to public
Em không đẩy codebase xong cho bên kia tự compile rồi chạy được vì cần setup môi trường nhiều (maven, openjdk-17,...)
Em tự compile thì không đẩy lên Github được vì có file ROOT.war của em lớn quá, cỡ 350 MB
Em nén lại thành Docker image rồi đẩy public lên Docker Hub rồi setup file cho người dùng tải về thì, mỗi tài khoản trên Docker Hub
I can't save my image to a .tar file because it's size is big too (450 MB)