#AzureChallengeTeam2
<br>
Actual Task: <br>
The first version (large VNET) of the solution should have:<br>
-    A running App Service Environment (ASE)<br>
-    An App Service Plan on tier I1v2<br>
-    An Azure Function and a Logic App running on this App Service Plan (both on same)<br>
-    Deployment set up in Azure Devops<br>
-    Deploy a simple demo API in the Azure Function<br>
-    The HTTP endpoints should not be accessible from outside the network<br>
<br><br>
Version two (small VNET) needs to add:<br>
-    A separate VNET with peering to the previous on<br>
-    API Management on tier Developer<br>
-    Application Gateway with Web Application firewall<br>
-    Allow traffic to Function app through Application Gateway and API Management only from location specified (Cegal office)<br>
<br>
IMPORTANT: <br>

- The ASE and App Service Plan are the most expensive resources, please don’t create more than one and don’t let them run for too long.<br>
- And for API Management, only 2 tiers support network isolation, Developer and Premium. Developer is almost for free, Premium cost 25000 NOK per month, choose Developer.<br>
<br><br><br>

Plan ?? <br>

Step 1: Oraganization.<br>
    - Create RGs<br>
        - Network<br>
        - App<br>
        - Mgmt (storage bucket & .tfstatefile)<br>
Step 2: Network<br>
    - Network RG (part of task version2)<br>
        - Create network resource
            - 2 vNets (Hub (WAF / API Gateway) to App) with peering<br>
            - NSG to allow traffic between vNets<br>
            - Create WAF & API Gateway (use Developer tier)<br>
    - App RG (part of task version1)<br>
Step 3: Compute<br>
    - Create the compute resources:<br>
            - App Service Plan (tier I1v2)<br>
            - App service<br>
            - Function APP<br>
Step 4: (part of task version1)<br>
    - DevOps Pipeline<br>
<br>
# Terraform<br>
<br>
# What you are doing - List of steps<br>
1.<br>
2.<br>
3.<br>
<br>
## Requirements and install instructions<br>
<br>
1. Running Terraform:<br>

* terraform init<br>
* terraform validate<br>
* terraform plan !! Remember to review the plan !!<br>
* terraform apply<br>
<br>
## Removal of stack<br>
In case you want to remove created resources:<br>
* terraform destroy<br>
<br>
## Additional notes<br>
<br>
You can freely change the variables in the variables.tf depending what you need. One could potentially try different amount of servers by adding new instance names. Try and test!<br>
