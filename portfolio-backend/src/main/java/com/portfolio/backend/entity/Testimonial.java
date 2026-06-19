package com.portfolio.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "testimonials")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Testimonial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "client_name", nullable = false)
    private String clientName;

    @Column(name = "client_company", nullable = false)
    private String clientCompany;

    @Column(name = "client_role", nullable = false)
    private String clientRole;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String feedback;

    @Column(name = "client_image_url")
    private String clientImageUrl;

    @Column(name = "display_order", nullable = false)
    private Integer displayOrder;
}
