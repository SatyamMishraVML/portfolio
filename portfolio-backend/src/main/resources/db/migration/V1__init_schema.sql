-- V1__init_schema.sql
-- Create schema for portfolio-backend database

-- 1. Projects Table
CREATE TABLE projects (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    image_url VARCHAR(500),
    demo_url VARCHAR(500),
    github_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Project Technologies (ElementCollection)
CREATE TABLE project_technologies (
    project_id BIGINT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    technology VARCHAR(255) NOT NULL,
    PRIMARY KEY (project_id, technology)
);

-- 2. Blog Posts Table
CREATE TABLE blog_posts (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    image_url VARCHAR(500),
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Blog Post Tags (ElementCollection)
CREATE TABLE blog_post_tags (
    blog_post_id BIGINT NOT NULL REFERENCES blog_posts(id) ON DELETE CASCADE,
    tag VARCHAR(255) NOT NULL,
    PRIMARY KEY (blog_post_id, tag)
);

-- 3. Skills Table
CREATE TABLE skills (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(50) NOT NULL,
    proficiency INTEGER NOT NULL,
    display_order INTEGER NOT NULL
);

-- 4. Experiences Table
CREATE TABLE experiences (
    id BIGSERIAL PRIMARY KEY,
    company VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BOOLEAN NOT NULL DEFAULT FALSE,
    display_order INTEGER NOT NULL
);

-- 5. Testimonials Table
CREATE TABLE testimonials (
    id BIGSERIAL PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    client_company VARCHAR(255) NOT NULL,
    client_role VARCHAR(255) NOT NULL,
    feedback TEXT NOT NULL,
    client_image_url VARCHAR(500),
    display_order INTEGER NOT NULL
);

-- 6. Contact Messages Table
CREATE TABLE contact_messages (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for performance tuning
CREATE INDEX idx_projects_slug ON projects(slug);
CREATE INDEX idx_blog_posts_slug ON blog_posts(slug);
CREATE INDEX idx_skills_category ON skills(category);
