package put.poznan.sport.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import put.poznan.sport.exception.exceptionClasses.PictureUploadException;

import java.io.File;

@RestController
@RequestMapping("api/resource/")
public class ResourceController {

    @Value("${file.upload-dir}")
    private String uploadDir;

    @PostMapping("picture")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) {
        try {

            String contentType = file.getContentType();
            if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
                throw new PictureUploadException("Dozwolone są tylko pliki JPG i PNG");
            }

            String fileName = file.getOriginalFilename();
            File destinationFile = new File(uploadDir + fileName);

            if (destinationFile.exists()) {

                String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
                String baseName = fileName.substring(0, fileName.lastIndexOf('.'));
                String newFileName = baseName + "_" + System.currentTimeMillis() + fileExtension;
                destinationFile = new File(uploadDir + newFileName);
            }

            file.transferTo(destinationFile);
            return ResponseEntity.ok(destinationFile.getName());

        } catch (Exception exception) {
            throw new PictureUploadException("Błąd zapisu pliku");
        }
    }

}
