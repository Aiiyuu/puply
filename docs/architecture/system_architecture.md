# Engineering Specification: Puply.dog

This document defines the technical ecosystem for **Puply.dog**. The project is architected as a **pnpm monorepo** to allow seamless code sharing, type synchronization, and unified dependency management between the Golang backend, Next.js web platform, and React Native mobile application.

---

## 1. Infrastructure & Monorepo
The backbone of the project, focusing on workspace efficiency and cloud-native scalability.

| Technology | Badge | Purpose |
| :--- | :--- | :--- |
| **Monorepo** | ![pnpm](https://img.shields.io/badge/pnpm-F69220?style=for-the-badge&logo=pnpm&logoColor=white) | Core workspace manager for sharing interfaces and logic across all packages. |
| **Containerization** | ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) | Standardizing environments across development and AWS deployment. |
| **Cloud Hosting** | ![AWS](https://img.shields.io/badge/Amazon_AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white) | Production hosting, S3 media storage, and serverless tasks. |
| **Automation** | ![GNU Make](https://img.shields.io/badge/Make-000000?style=for-the-badge&logo=gnu-make&logoColor=white) | Task orchestration for Orval generation, migrations, and builds. |
| **Remote Access** | ![SSH](https://img.shields.io/badge/SSH-000000?style=for-the-badge&logo=openssh&logoColor=white) | Secure infrastructure management. |
| **AI Standards** | ![Cursor](https://img.shields.io/badge/Cursor-000000?style=for-the-badge&logo=cursor&logoColor=white) | Custom `.cursor` rules for project-wide AI consistency. |

---

## 2. Backend (API Layer)
A high-performance Go-based REST API designed for safety, speed, and real-time capability.

| Technology | Badge | Purpose |
| :--- | :--- | :--- |
| **Language** | ![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white) | Compiled performance for concurrent tasks and WebSockets. |
| **Framework** | ![Gin](https://img.shields.io/badge/Gin-008ECF?style=for-the-badge&logo=go&logoColor=white) | High-speed routing engine with a minimal memory footprint. |
| **Database** | ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white) | Relational storage with PostGIS for location-based matching. |
| **ORM** | ![Prisma](https://img.shields.io/badge/Prisma-2D3748?style=for-the-badge&logo=prisma&logoColor=white) | Type-safe database access and automated migrations. |
| **Real-time** | ![WebSockets](https://img.shields.io/badge/WebSockets-010101?style=for-the-badge&logo=socketdotio&logoColor=white) | Instant messaging and live presence status. |
| **API Docs** | ![Swagger](https://img.shields.io/badge/Swagger-85EA2D?style=for-the-badge&logo=swagger&logoColor=black) | Automated OpenAPI documentation serving as the source of truth. |
| **Caching** | ![Redis](https://img.shields.io/badge/redis-%23DD0031.svg?style=for-the-badge&logo=redis&logoColor=white) | Fast in-memory storage for session management and WebSocket heartbeats. |

---

## 3. Frontend (Web & UI)
A modern, responsive web application built for optimal performance and SEO.

| Technology | Badge | Purpose |
| :--- | :--- | :--- |
| **Framework** | ![Next.js](https://img.shields.io/badge/Next-000000?style=for-the-badge&logo=nextdotjs&logoColor=white) | SSR/ISR for fast landing pages and client-side discovery logic. |
| **Language** | ![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white) | Static typing to prevent runtime errors across the stack. |
| **UI Library** | ![shadcn/ui](https://img.shields.io/badge/shadcn/ui-000000?style=for-the-badge&logo=shadcnui&logoColor=white) | Accessible, Tailwind-styled components. |
| **Data Fetching** | ![TanStack Query](https://img.shields.io/badge/TanStack_Query-FF4154?style=for-the-badge&logo=react-query&logoColor=white) | Caching, synchronization, and optimistic UI swipe logic. |
| **HTTP Client** | ![Axios](https://img.shields.io/badge/Axios-5A29E4?style=for-the-badge&logo=axios&logoColor=white) | Reliable HTTP client utilized by generated Orval hooks. |
| **Icons** | ![Lucide](https://img.shields.io/badge/Lucide-000000?style=for-the-badge&logo=lucide&logoColor=white) | Scalable vector icons for a consistent UI language. |
| **Visuals** | ![Chart.js](https://img.shields.io/badge/Chart.js-FF6384?style=for-the-badge&logo=chartdotjs&logoColor=white) | Dynamic statistics and match-ratio charts. |
| **Code Gen** | ![Orval](https://img.shields.io/badge/Orval-6D28D9?style=for-the-badge) | Syncing backend Swagger models into mobile TS interfaces. |
---

## 4. Mobile (Native Layer)
Native iOS and Android experience with maximum code reusability.

| Technology | Badge | Purpose |
| :--- | :--- | :--- |
| **Mobile Core** | ![React Native](https://img.shields.io/badge/React_Native-61DAFB?style=for-the-badge&logo=react&logoColor=black) | Driving native mobile components with React logic. |
| **Environment** | ![Expo](https://img.shields.io/badge/Expo-000020?style=for-the-badge&logo=expo&logoColor=white) | Accelerated development workflow and OTA updates. |
| **Code Gen** | ![Orval](https://img.shields.io/badge/Orval-6D28D9?style=for-the-badge) | Syncing backend Swagger models into mobile TS interfaces. |

---

## 5. Testing Strategy
Comprehensive testing across all layers of the monorepo to ensure stability.

| Tier | Technology | Badge | Purpose |
| :--- | :--- | :--- | :--- |
| **Unit (API)** | **Testify** | ![Go](https://img.shields.io/badge/Testify-00ADD8?style=for-the-badge) | Validating Go services and API handlers. |
| **Unit (Web)** | **Jest** | ![Jest](https://img.shields.io/badge/Jest-C21325?style=for-the-badge&logo=jest&logoColor=white) | Testing React components and utility functions. |
| **Unit (Mobile)** | **RNTL** | ![RNTL](https://img.shields.io/badge/Testing_Library-E33332?style=for-the-badge&logo=testing-library&logoColor=white) | Testing React Native components and interactions. |
| **E2E (Web)** | **Playwright** | ![Playwright](https://img.shields.io/badge/Playwright-2EAD33?style=for-the-badge&logo=playwright&logoColor=white) | Simulating user flows in the browser. |
| **E2E (Mobile)** | **Detox** | ![Detox](https://img.shields.io/badge/Detox-000000?style=for-the-badge) | Gray-box end-to-end testing for the mobile app. |

---

## 6. Specialized Services
Integration of cloud-native and third-party solutions.

| Service | Technology | Description |
| :--- | :--- | :--- |
| **Auth** | ![OAuth2](https://img.shields.io/badge/OAuth2-000000?style=for-the-badge&logo=google&logoColor=white) | JWT sessions with Google/Facebook social providers. |
| **Safety** | ![Amazon Rekognition](https://img.shields.io/badge/Rekognition-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white) | Automated NSFW image moderation for dog profiles. |
| **Email** | ![Resend](https://img.shields.io/badge/Resend-000000?style=for-the-badge&logo=resend&logoColor=white) | Transactional email engine with React templates. |
| **Interactions** | ![dnd kit](https://img.shields.io/badge/dnd--kit-000000?style=for-the-badge) | Accessible drag-and-drop for the profile photo gallery. |

