# API de Gestão de Livros (Flask) 📚

Esta é uma API RESTful simples desenvolvida em **Python** utilizando a framework **Flask**. O projeto foi criado para demonstrar o funcionamento de operações CRUD (Create, Read, Update, Delete) em uma coleção de livros armazenada em memória.

---

## 🚀 Funcionalidades

A API permite realizar as seguintes ações:

* **Listar todos os livros:** Consulta a base de dados completa.
* **Obter livro por ID:** Filtra e retorna um livro específico.
* **Adicionar novo livro:** Insere um título inédito na coleção.
* **Editar livro:** Atualiza as informações de um livro existente.
* **Eliminar livro:** Remove um registo da lista.

---

## 🛠️ Tecnologias Utilizadas

* **Python 3.x**
* **Flask** (Framework Web)
* **JSON** (Formato de intercâmbio de dados)

---

## 📦 Instalação e Configuração

Copie e cole os comandos abaixo no seu terminal para configurar e executar o projeto:

```bash
# Clonar o repositório
git clone [https://github.com/Ikajira/api-livros-flask.git](https://github.com/Ikajira/api-livros-flask.git)
cd api-livros-flask

# Criar e ativar o ambiente virtual
python -m venv venv
# No Windows: venv\Scripts\activate | No Linux/Mac: source venv/bin/activate

# Instalar dependências e rodar a aplicação
pip install flask
python app.py
