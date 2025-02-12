# Taski - Gerenciador de Tarefas

Bem-vindo ao Taski, um aplicativo de gerenciamento de tarefas desenvolvido em Flutter 3.24.4. Este projeto foi criado para ajudar os usuários a organizar suas tarefas diárias de forma eficiente.

## Novidades 🚀

Este projeto agora utiliza o **Design System** desenvolvido para ele e para os próximos projetos. Isso garante consistência visual e facilita a manutenção do código. Além disso, foi criado um **CustomList**, que auxilia os desenvolvedores a identificarem quando devem utilizar os componentes do Design System ao invés de widgets personalizados.

## Pré-requisitos

Antes de começar, certifique-se de ter o seguinte instalado em sua máquina:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/)

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

- `lib/`: Contém o código-fonte do aplicativo.
- `pubspec.yaml`: Arquivo de configuração do Flutter que lista as dependências do projeto.



## Arquitetura 🚀

Esse projeto trabalha com o conceito de arquitetura limpa, separando o projeto em três camadas principais:

- data
- domain
- presentation



### Presentation

É a camada de interação com o usuário. Você obviamente precisa de widgets para exibir algo na tela. Esses widgets então despacham eventos para o Bloc ou são acionados por métodos e um Cubit e escutam os estados.

### Domain

Ele conterá apenas a lógica de negócios principal (use cases) e objetos de negócios (entities). Deve ser totalmente independente de todas as outras camadas.

### Data

A camada de "data" consiste em uma implementação de "repository" (o contrato vem da camada de "domain") e "data sources" - uma geralmente é para obter dados "remote" (API) e a outra para armazenar em cache esses dados. O repository é onde você decide se deseja retornar dados atualizados ou armazenados em cache, quando armazená-los em cache e assim por diante.

O projeto utiliza:

- **GetIt** para injeção de dependência
- **Bloc/Cubit** para gerenciamento de estado
- **SQLite** para armazenamento local de tarefas

## O que está incluso no projeto? 🌟

✅   - Bloc architecture para código escalável e testável que oferece uma separação clara entre lógica de negócios e apresentação

✅   - Testes Unitários e Widgets e Integrados (Cobertura de testes: **83%**)

✅   - Lint, format, test, e aplicação de code coverage usando&#x20;

## Telas Implementadas

As telas foram implementadas seguindo o design que foi sugerido no [Figma](https://www.figma.com/design/eJ3Yn9Bv3eEAVh0kiz338h/Taski-To-Do-\(Copy\)?node-id=0-1\&p=f\&t=0a8Anem7lDSAUUry-0):

## Como Usar

Antes de tudo, configure o ambiente Flutter da sua máquina, veja mais em [Flutter Docs](https://flutter.dev/docs/get-started/install)

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/WemersonDamasceno/Taski
   ```

2. **Entre na pasta:**

   ```bash
   cd Taski
   ```

3. **Instale as dependências:**

   ```bash
   flutter pub get
   ```

4. **Execute o App:**

   ```bash
   flutter run
   ```

## Contribuindo

Se você deseja contribuir para este projeto, sinta-se à vontade para abrir uma issue ou enviar um pull request. Todas as contribuições são bem-vindas!

## Demonstração em Vídeo 🎥

Confira um vídeo demonstrativo do aplicativo em funcionamento:

[https://github.com/user-attachments/assets/d1407450-9567-4f56-95bd-d5154766d901](https://github.com/user-attachments/assets/d1407450-9567-4f56-95bd-d5154766d901)

O app pode ser baixado aqui: [Download aqui!](https://github.com/WemersonDamasceno/Taski/raw/refs/heads/main/assets/apk/taski.apk)

---

**Nota:** Certifique-se de que o Flutter está corretamente configurado em sua máquina antes de tentar executar o projeto.

