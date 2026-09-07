package org.puppit.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class S3Service {

    private final AmazonS3 amazonS3;

    //  업로드
    public Map<String, String> uploadFile(MultipartFile file, String folderName) throws IOException {
        String bucketName = "puppit-goodee-semi-857305036373-ap-northeast-2-an"; // ← 통일
        String fileName = folderName + "/" + UUID.randomUUID() + "_" + file.getOriginalFilename();

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType(file.getContentType());
        metadata.setContentLength(file.getSize());

        try (java.io.InputStream input = file.getInputStream()) {
            PutObjectRequest request = new PutObjectRequest(bucketName, fileName, input, metadata);
            // 상품 이미지는 브라우저가 S3 URL로 직접 읽으므로 업로드 시 공개 읽기를 지정합니다.
            if ("product".equals(folderName)) {
                request.withCannedAcl(CannedAccessControlList.PublicRead);
            }
            amazonS3.putObject(request);
        }

        String fileUrl = amazonS3.getUrl(bucketName, fileName).toString();

        Map<String, String> result = new HashMap<>();
        result.put("fileName", fileName);
        result.put("fileUrl", fileUrl);
        return result;
    }

    //  삭제
    public void deleteFile(String fileUrl) {

        String bucketName = "puppit-goodee-semi-857305036373-ap-northeast-2-an"; // ← 업로드랑 동일하게
        String fileKey = fileUrl.substring(fileUrl.indexOf(bucketName) + bucketName.length() + 1);

        amazonS3.deleteObject(bucketName, fileKey);
    }
}
