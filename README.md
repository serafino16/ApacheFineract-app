# ApacheFineract-app
Apache Fineract is an open-source platform for core banking and financial services.
Application consist of 10 microservices.The languages for the application are java 17 for backend and HTML/CSS/JavaScript for frontend.For build process is used maven:3.8.6.PostgreSQL for RDS and Redis for cache.

Docker: backend image-for dev/stage maven:3.8.6-eclipse-temurin-17 AS dev-builder for prod maven:3.8.6-eclipse-temurin-17 AS prod-builder to eclipse-temurin:17-jdk-alpine defined in multi stage build.For fronted image-node:18 with  images for dev/stage and for prod cleaned for unecessary dependencies.Standart images for PostgreSQL and Redis.

Kubernetes services : you can check the folder services ,every file is combined to have deployment,service and service account. Deployment file consist of replicas,image from ecr,service account name,resource request and limit,livness and readiness probe volume mount for efs for backend services and ebs for database and redis. Service account is connected to eks-irsa. Service contains load balancers with annotations for ALB and NLB. Database contains headless service and also verticaland horizontal load balancers and secrets.

For CI/CD is used jenkins.

EKS: it has 3 clusters dev/stage shared,prod and prodbackup. In regions EU-WEST-1 EU-WEST-2 EU-WEST-3.In the cluster are used public and private node groups,cluster autoscaler and ecr.

EKS_IRSA:Config for iam for service account with oidc token and necessary policies and permissions.

Ingress controller to work with ALB for the services with Http and NLB for RDS and Redis.
