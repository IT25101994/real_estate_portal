package com.realestate.portal.util;

import java.io.*;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Stream;

public class Refactor {
    public static void main(String[] args) throws Exception {
        Path srcPath = Paths.get("c:\\Users\\kvvse\\Test-Projects\\real-estate-portal\\portal\\src\\main");

        // 1. Rename inside files
        try (Stream<Path> walk = Files.walk(srcPath)) {
            walk.filter(Files::isRegularFile).forEach(path -> {
                try {
                    String content = new String(Files.readAllBytes(path), StandardCharsets.UTF_8);
                    
                    String updated = content
                        .replace("management", "management")
                        .replace("Management", "Management")
                        .replace("MANAGEMENT", "MANAGEMENT")
                        .replace("sellers", "sellers")
                        .replace("Sellers", "Sellers")
                        .replace("SELLERS", "SELLERS")
                        .replace("seller", "seller")
                        .replace("Seller", "Seller")
                        .replace("SELLER", "SELLER")
                        .replace("management", "management")
                        .replace("Management", "Management")
                        .replace("MANAGEMENT", "MANAGEMENT");
                        
                    if (!content.equals(updated)) {
                        Files.write(path, updated.getBytes(StandardCharsets.UTF_8));
                        System.out.println("Updated: " + path);
                    }
                } catch (Exception e) {
                    System.err.println("Could not process " + path + ": " + e);
                }
            });
        }
        
        // 2. Rename files/directories
        List<Path> allPaths = Files.walk(srcPath).sorted((p1, p2) -> p2.getNameCount() - p1.getNameCount()).toList();
        for (Path path : allPaths) {
            File f = path.toFile();
            String name = f.getName();
            String newName = name.replace("Seller", "Seller").replace("seller", "seller");
            
            if (!name.equals(newName)) {
                File newFile = new File(f.getParentFile(), newName);
                if (f.renameTo(newFile)) {
                    System.out.println("Renamed: " + f + " -> " + newFile);
                } else {
                    System.err.println("Failed to rename: " + f);
                }
            }
        }
        System.out.println("File renaming completed.");
    }
}
