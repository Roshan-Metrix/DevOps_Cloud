# Jenkins CI/CD Pipeline

This repository contains resources and guidance for implementing a Jenkins-based CI/CD pipeline.

## Folder Structure

```text
Jenkins/
`-- README.md
```

## Click To Navigate

- [Jenkins/README.md](README.md)
- [Back to repository README](../README.md)

## Overview

Jenkins is an open-source automation server used to build, test, and deploy software. A Jenkins CI/CD pipeline automates the steps from code commit to production deployment.
Key concepts:
- Master/Controller and Agents (slaves)
- Jobs and Pipelines
- Jenkinsfile (Declarative or Scripted)
- Plugins for SCM, notifications, and integrations

## Typical Pipeline Stages

1. Checkout: Fetch source code from SCM (e.g., GitHub).
2. Build: Compile or package the application (Maven, Gradle, npm).
3. Test: Run unit, integration, and static analysis tests.
4. Artifact: Publish artifacts to a repository (Nexus, Artifactory).
5. Deploy: Deploy to environments (staging, production) using tools like Ansible, Helm, Terraform, or kubectl.
6. Notify: Send build/deploy notifications to Slack, email, or other channels.

## Example Jenkinsfile (Declarative)

```groovy
pipeline {
	agent any
	environment {
		// Define credentials and environment variables
		MAVEN_OPTS = '-Xmx1024m'
	}
	stages {
		stage('Checkout') {
			steps {
				checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/your/repo.git']]])
			}
		}
		stage('Build') {
			steps {
				sh 'mvn -B clean package'
			}
		}
		stage('Test') {
			steps {
				sh 'mvn test'
				junit 'target/surefire-reports/*.xml'
			}
		}
		stage('Publish') {
			steps {
				// Publish artifacts or Docker images
			}
		}
		stage('Deploy') {
			when { branch 'master' }
			steps {
				// Deploy to staging/production
			}
		}
	}
	post {
		success { echo 'Build succeeded' }
		failure { echo 'Build failed' }
	}
}
```

## Best Practices

- Keep Jenkinsfile versioned with the application repository.
- Use agents with required tools preinstalled or use containerized builds.
- Secure credentials with Jenkins Credentials Store and avoid plaintext secrets.
- Use pipeline libraries and shared steps to reduce duplication.
- Enable pipeline durability and define timeouts for long-running stages.

## Security

- Restrict who can configure jobs and access sensitive credentials.
- Keep Jenkins and plugins up to date.
- Use RBAC and integrate with SSO where possible.

## Troubleshooting Tips

- Check Jenkins logs and job console output for errors.
- Validate Jenkinsfile syntax with the Pipeline Linter.
- Ensure agents have network access to required services (SCM, artifact repos).

## References

- Jenkins: https://www.jenkins.io
- Pipeline as Code: https://www.jenkins.io/doc/book/pipeline/

Feel free to adapt the example Jenkinsfile and stages to your project's needs.
