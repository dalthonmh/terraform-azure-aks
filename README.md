# terraform-azure-aks

comandos principales:

Iniciar sesion:

```sh
az login
```

Ver suscripciones disponibles

```sh
az account list --output table
```

Primero creamos un service principal con el comando

```sh
az ad sp create-for-rbac --name myAKSClusterServicePrincipal
```

esto nos dará algo como:

```json
{
  "appId": "",
  "displayName": "",
  "password": "",
  "tenant": ""
}
```

Luego tenemos que crear un ID secreto para autorizar y autenticarnos a los servicios de azure

```sh
az ad app credential reset --id <appId>
```

Esto generará una salida como esta:

```json
{
  "appId": "",
  "password": "", # segundo
  "tenant": ""
}
```

Creamos el archivo terraform.tfvars

En este pondremos el appId que nos salio y el password segundo

```json
aks_service_principal_app_id = "...91f"
aks_service_principal_client_secret = "-rq8..."
cluster_name = "k8stest"
```

Ejecutar normalmente

```sh
terraform init
terraform plan
terraform apply --auto-approve
```

En caso de que salga error como

```sh
│ Error: a resource with the ID "/subscriptions/6...c81/resourceGroups/aks-admision/providers/Microsoft.Network/virtualNetworks/aks-admision-vnet" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_virtual_network" for more information

```

Comando para importar:

```sh
terraform import azurerm_virtual_network.vnet-aks-admision /subscriptions/...81/resourceGroups/aks-admision/providers/Microsoft.Network/virtualNetworks/aks-admision-vnet
```

Para conectarse

```sh
az aks get-credentials --resource-group aks-admision --name k8stest
```

guia:
[Crear Cluster AKS en Azure con Terraform](https://red-orbita.com/posts/2023/02/crear-cluster-aks-en-azure-con-terraform/)

Listo!
