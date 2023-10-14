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

> We also gave Terraform instructions, using blocks of code known as data resource blocks, to automatically install Python and Jenkins. This way, once the instances are set up, Python and Jenkins are ready to be used without us doing additional installations.

> 




