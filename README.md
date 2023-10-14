# Deployment 5 
- By Joseph White
- October 24, 2023

## Description
This deployment aims to build an infrastructure using IoC and deploy an application, in this case, Terraform. Terraform leverages the powerful infrastructure as code (IaC) tool, to provision and manage infrastructure efficiently, consistently, and scalable.

## Getting Started/Installation/Steps
[Main.tf file][https://github.com/z0sun/deployment5/blob/main/main.tf]

> In our main.tf file, we've written instructions for Terraform, a tool that helps us set up our online environment without manual clicking and configuring. Think of it as an automated builder for our online space. Here's what we did:

> Setting Up the Online Space (VPC): We asked Terraform to create a private space in the cloud where our applications can live. This is like securing a plot of land before building on it.

> Creating Two Virtual Computers (EC2 instances): Within that space, we told Terraform to set up two virtual computers. These computers are placed in two different zones to ensure our applications are always available, even if there's a hiccup in one zone.

> Installing Software with Templates: Instead of manually going into each virtual computer to install software, we used something called data resource blocks. These are like ready-made software installation templates. With their help, as soon as our virtual computers are ready, Python (a popular programming language) and Jenkins (a tool that helps us update our applications smoothly) get installed automatically.

> So, to sum it up: Our main.tf file gives Terraform a blueprint of our desired online space, and once Terraform reads this blueprint, it goes ahead and builds everything for us, including installing the necessary software on our virtual computers.

**** 

### Jenkins/Python Install 
Note: Jenkins and Python were installed on instance 1, Python was installed on instance 2 

> We also gave Terraform instructions, using blocks of code known as data resource blocks, to automatically install Python and Jenkins. This way, once the instances are set up, Python and Jenkins are ready to be used without us doing additional installations.
```
 `data "template_file" "jenkins_file" {
  template = file("${path.module}/jenkins.sh")
}

data "template_file" "python_install" {
  template = file("${path.module}/pythoninstall.sh")
}`
```
> [Jenkins Install][https://github.com/z0sun/deployment5/blob/main/scripts/jenkinsinstall]
> [Python Install][https://github.com/z0sun/deployment5/blob/main/scripts/pythoninstall.sh]

**** 

### SSH & Download Script 
[Jenkinsfilev1][https://github.com/z0sun/deployment5/blob/main/Jenkinsfilev1]
[Jenkinsfilev2][https://github.com/z0sun/deployment5/blob/main/Jenkinsfilev2]

> Utilizing commands in Jenkinsfilev1 and Jenkinsfilev2 to SSH into a secondary instance and execute specific scripts makes a strategic approach to managing and deploying applications. This enhances the CI/CD pipeline by enabling the Jenkins automation server to interact seamlessly with different instances, optimizing resource utilization, and enforcing a structured deployment workflow. By SSHing into the second instance, we ensure that workloads can be distributed and executed in a segregated manner, which not only isolates potential issues to a specific instance but also facilitates parallel operations, thereby speeding up the build and deployment process. By dynamically downloading and executing scripts per step in the Jenkinsfile, we introduce an element of flexibility and reusability to our pipeline, allowing for dynamic adjustments and automating configurations or applications tailored to the specifics of a given stage or environment, all while maintaining a clean and organized codebase in our version control.

****

### Multibranch Pipeline Jenkinsfilev1
[image][https://github.com/z0sun/deployment5/blob/main/Jenkinsfilev1.png]

> Once you've set up your environment, deploying your application using Jenkins is a breeze with our predefined pipeline in Jenkinsfilev1. In a nutshell, Jenkinsfilev1 is like a recipe that tells Jenkins exactly how to deploy our application step-by-step. Jenkins will look at Jenkinsfilev1 and follow the steps outlined in it, which include logging into our second virtual computer instance, grabbing the necessary update script, and running it. This way, even complex updates to our application become as easy as pushing a button. Here’s a simplified walkthrough:

> Launch Jenkins: Open up Jenkins on your web browser - you'll typically find it at your-Jenkins-ip:8080.

> Start a New Pipeline: Navigate to "New Item", create a 'Pipeline', and give it a name, perhaps something like "AppUpdatePipeline".

> Link to GitHub: Under the Pipeline configuration, link Jenkins to the GitHub repository where Jenkinsfilev1 is stored. This is like telling Jenkins where your recipe is located.

> Run the Pipeline: Once configured, you simply 'Build' the pipeline and Jenkins will follow the steps in Jenkinsfilev1, ensuring your application is updated automatically and exactly as specified in the file.

#### Jenkinsfilev2
[image][https://github.com/z0sun/deployment5/blob/main/Screen%20Shot%202023-10-14%20at%204.15.04%20AM.png]

> Jenkinsfilev2 is our simplified guide for updating our app using Jenkins. It has two main steps: Clean and Deploy. First, the Clean step makes sure our workspace is neat, with no leftover data from earlier updates. Then, the Deploy step helps us easily and accurately update our app by following the set instructions. Think of Jenkinsfilev2 as a straightforward two-step checklist that Jenkins follows to help us keep our app updated without any mess or complications.






