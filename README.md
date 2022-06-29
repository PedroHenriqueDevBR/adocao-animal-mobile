<h1 align="center">:dog: Adoção de animais - Mobile :cat:</h1>

<p align="center">
Este projeto está sendo desenvolvido para a disciplina de projeto integrador, ministrada no Instituto Federal do Piauí (Campus Central).
</p>

<p align="center">
<img alt="Developer" src="https://img.shields.io/badge/Developer-PedroHenriqueDevBR-green">
<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/pedrohenriquedevbr/adocao-animal-mobile">
<img alt="Mobile" src="https://img.shields.io/badge/Mobile-Flutter-blue">
<img alt="Back-end" src="https://img.shields.io/badge/Backend-Django-green">
</p>

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/adocao-animal-mobile/main/docs/modelagem/capa.png" />

# :memo: Visão Geral

Aplicação desenvovida para se comunicar com o backend do projeto adoçõ doguinho, que está disponível no seguinte link ![Adoção de animais - Clique aqui para saber mais](https://github.com/PedroHenriqueDevBR/adocao-doguinho).

 * <strong><a href="#description">Descrição completa da aplicação</a></strong>
 * <strong><a href="#tecnologias">Tecnologias utilizadas</a></strong>
 * <strong><a href="#modelagem">Modelagem da aplicação</a></strong>
    * <strong><a href="#modelagem-classes">Modelagem das classes</a></strong>
    * <strong><a href="#modelagem-mapa-aplicacao">Mapa da aplicação</a></strong>
 * <strong><a href="#requisitos">Pré-requisitos</a></strong>
 * <strong><a href="#instalacao">Instalação</a></strong>
 * <strong><a href="#funcionalidades">Funcionalidades</a></strong>
 * <strong><a href="#screenshots">Screenshots</a></strong>

<h1 id="description">:speech_balloon: Descrição</h1>

**Trata-se do desenvolvimento de uma aplicação para facilitar o controle das informações por parte das organizações que disponibilizam animais para adoção.**

Essa aplicação está sendo desenvolvida para facilitar o uso das funcionalidades do projeto **adoção de animais**, o projeto adoção de animais possui o backend em Django já implementado e um frontend em Angular que consome os dados e disponiiliza para o usuário, a aplicação frontend em Angular possui todos as funcionalidades para quem deseja colocar um animal para adoção e para quem deseja adotar um animal.

Essa aplicação possui o objetivo de atender os usuários que desejam colocar os animais para a adoção, pois são eles quem mais vão precisar ficar acessando o sistema para verifiar o status das adoções e as informações dos animais.

<br>

<h1 id="tecnologias">:rocket: Tecnologias utilizadas</h1>

<br>

* <img alt="Dart" src="https://img.shields.io/badge/-Dart-blue"> - Linguagem de programação utilizada no desenvolvimento da aplicação.
* <img alt="Flutter" src="https://img.shields.io/badge/-Flutter-blue"> - Framework que utiliza a linguagem de programação Dart para o desenvolvimento da aplicação.

<h1 id="modelagem">:bulb: Modelagem das classes</h1>

Esta seção irá mostrar como a aplicação foi modelada para que pudesse atender todas as necessidades propostas da descrição do desafio.

A modelagem foi criada antes de iniciar o desenvolvimento da aplicação, com o objetivo de guiar o desenvolvimento e evitar erros que pudessem atrapalhar o andamento do projeto.

<h2 id="modelagem-classes">Modelagem do banco de dados</h2>

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/adocao-animal-mobile/main/docs/modelagem/adocao-local-mobile.png" />

<h2 id="modelagem-classes">Diagrama de casos de uso</h2>

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/adocao-animal-mobile/main/docs/modelagem/casos-de-uso.png" />

<h2 id="modelagem-mapa-aplicacao">Protótipo da aplicação</h2>

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/adocao-animal-mobile/main/docs/prototipo/all.png" />

<h1 id="requisitos">:warning: Pré-requisitos</h1>

O desenvolvimento dessa aplicação utiliza como base as seguintes tecnologias e versões apresentadas abaixo.

```bash
1. Dart: 2.0.0
2. Flutter: 2.0.0
```

<h1 id="instalacao">:information_source: Instalação</h1>

```bash
# Execute o comando abaixo e clone o repositório do projeto
git clone git@github.com:PedroHenriqueDevBR/adocao-animal-mobile.git

# Acesse o projeto
cd adocao-animal-mobile/adocao_local/

# Execute o comanmdo para obter as dependências do projeto
flutter pub get 

# Execute o comanmdo para que o flutter mobx possa gerar os aquivos necessários
flutter pub run build_runner build

# Por fim, para executar o projeto execute o comando abaixo
flutter run 
```

<h2 id="funcionalidades">:heavy_check_mark: Funcionalidades</h2>

- [X] Cadastrar usuário
- [X] Login
- [X] Editar perfil
- [X] Adicionar animal
- [X] Adicionar foto do animal
- [X] Adicionar vacina
- [X] Bloquear/Desbloquear animal
- [X] Deletar animal
- [X] Visualizar solicitações e adoção
- [X] Responder solicitação de adoção
