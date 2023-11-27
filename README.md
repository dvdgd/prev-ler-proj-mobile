# Projeto Mobile do Curso Sistemas de Informação da Faculdade Cesgranrio

# Setup

run `flutter pub get`

# Integrando com o backend

- Criar um arquivo ".env" na raiz do projeto
- Preencher as informações que estão no arquivo de exemplo ".env.example"

Exemplo das informações preenchidas:
```env
SUPABASE_URL=YOUR_SUPABASE_URL
SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

# DOING List
- Persistir a sessão do usuário ao fechar o aplicativo.
- CRUD de exercícios.

# DONE List
- Refatoração de login e registro para o supabase
- CRUD de Lesões (enfermidades)
- CRUD de conteúdo puro (sem relacionar lesões)

# TODO List
- Relacionar a criacao de conteudo com mais de uma lesão (enfermidade).
- Listar sobre quais lesões um conteúdo é.
- Criar nova tela de perfil.
- Regra de não permitir uma empresa com assinatura expirada acessar o aplicativo (mostrar mensagem que a assinatura está expirada).
