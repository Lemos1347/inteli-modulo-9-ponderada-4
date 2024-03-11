# Integração do Simulador com Metabase

## 1. Objetivo

Este projeto visa criar um simulador de dispositivos IoT que utiliza o protocolo MQTT para enviar informações simuladas baseadas em dados de sensores reais, nesse caso o [Sensor de Radiação Solar Sem Fio HOBOnet RXW-LIB-900](https://sigmasensors.com.br/produtos/sensor-de-radiacao-solar-sem-fio-hobonet-rxw-lib-900) e itegra-lo a um dashboard (nesse caso o [metabase](https://www.metabase.com/))

## 2. Como Instalar e Rodar

### Pré-requisitos

- Credenciais de um broker (recomendamos [Mosquitto](https://mosquitto.org/))
- (Docker)[https://www.docker.com/] e (docker-compose)[https://docs.docker.com/compose/] instalado

> [!IMPORTANT]
> Caso queira editar o código ou rodá-lo de outra maneira, tenha instalado [go](https://go.dev/doc/install) em sua máquina.

### Instalação

Clone o repositório para a sua máquina local:

```bash
git clone https://github.com/Lemos1347/inteli-modulo-9-ponderada-4
cd inteli-modulo-9-ponderada-4
```

> [!NOTE]
> Caso queira editar o projeto, lembre de instalar as depencias:
>
> ```bash
> go mod tidy
> ```

### Execução

> [!IMPORTANT]
> Antes de rodar a aplicacao, garanta que tenha um broker rodando, caso seja mosquitto, rode com as configuracoes desse projeto:
>
> ```bash
> mosquitto -c ./configs/mosquitto.conf
> ```

````

Caso queira modificar as credenciais, edite os aquivos `.env`, mas caso queira apenas rodar, utilize as credenciais de template. Aqui descrevera passo a passo de como executar separadamente os conteudos desse projeto, execute tudo para ver a dash funcionando ao vivo.

#### Dashboard e banco de dados

Suba os containers docker com o docker-compose:

```bash
cd build ; docker compose up --build
````

Agora voce pode acessar a dashboard em (localhost:3000)[http://localhost:3000/], e caso voce nao tenha alterado nenhuma credencial, pode utilizar as seguintes credenciais para acessar:

```
user: supernicola@email.com
password: SuperNicola1
```

#### Publisher

O publisher nada mais e que a simulacao do sensor solar, ele ira publicar dados simulados em um topico MQTT. Para rodar ele, e apenas necessario executar o binario, passar o path para o arquivo do `.env` e a quantidade de sensores que voce quer criar (caso voce nao passe nada, ele emulara os sensores que ja existem, caso nao exista nenhum sensor e voce nao passe nenhum valor ele nao rodara):

```bash
./build/publisher ./configs/.env.publisher <numero>
```

Pronto! A partir de agora os dados serao publicados no topico "sensors/data".

#### Subscriber

O subscriber nada mais e que um servidor que organizara os dados advindos do topico "sensors/data" e os armazenara no banco de dados.

Para rodar ele, voce precisa executar o binario e passar o path para o arquivo do `.env`:

```bash
./build/subscriber ./configs/.env.subscriber
```

Pronto! Agora os dados enviados serao armazenados no banco de dados!

## 3. Estrutura do Projeto

O projeto é composto por .

- `build`: os executaveis e o docker da aplicacao
- `cmd`: entrypoint de todos os codigos em golang
- `configs`: arquivos de configuracao do projeto
- `internal`: codigos nao exportaveis do pacote golang

## 4. Demonstração do Funcionamento

https://github.com/Lemos1347/inteli-modulo-9-ponderada-4/assets/99190347/808e1c1d-2e33-4273-ab54-84e04753cc79

