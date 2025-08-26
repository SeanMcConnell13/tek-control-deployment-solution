**Part 2 — Container \& Kubernetes Security**

**Context**



The company is moving workloads into Docker and Kubernetes. Containers give speed and portability, but without guardrails they also hand attackers shortcuts into the cluster. The goal here is to show how we’d lock down both the container images themselves and the Kubernetes environment they run in.



**Docker Security Best Practices**



The container image is the first line of defense. A few practical rules make the difference between a hardened service and an attacker’s playground:



Start small: Use minimal base images (distroless, alpine) to shrink the attack surface.



Drop root: Run as a non-root user inside the container.



Keep secrets out: Never bake secrets into images; pull them at runtime from Key Vault or a secret store.



Stay current: Regularly rebuild and patch dependencies; scan images for known vulnerabilities.



Lock the filesystem down: Use a read-only root filesystem and drop unneeded Linux capabilities.





**Example: Dockerfile**





This image is small, stripped of shells/utilities, and runs as a non-root user — simple steps that remove entire classes of attacks.



Kubernetes Security Configuration



Even if containers are hardened, Kubernetes can undo that work if left wide open. SecurityContext and admission controls enforce least privilege at runtime.



RunAsNonRoot: Forces containers away from root execution.



ReadOnlyRootFilesystem: Blocks tampering with the pod’s filesystem.



Drop Linux Capabilities: Only give pods what they absolutely need.





**Example: k8s\\Deployment.yaml**





This configuration ensures the pod runs with no root access, no privilege escalation, and a read-only root filesystem. Even if compromised, the attacker is boxed in.



IaaS Security Considerations



Kubernetes doesn’t run in a vacuum — it sits on top of IaaS resources. Missteps here can negate all container security efforts.



Segmentation: Run worker nodes in private subnets; only expose via controlled gateways.



Identity, not secrets: Use managed identities for pod-to-service auth, not static keys.



Baseline hardening: Apply CIS benchmarks; let Defender for Cloud flag drift from best practice.



Monitoring: Collect flow logs, feed them into Sentinel, and auto-alert on strange egress.



**Why It Matters**





Containers give attackers speed too. A single root-running pod with a writable filesystem is enough for Mallory to move laterally, escalate, and own the cluster. By keeping images lean, stripping privileges, and surrounding them with Azure controls, we shut off the easy paths and force attackers into dead ends.

