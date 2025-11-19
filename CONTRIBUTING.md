# Contribuindo para SecurityCraft Camera Monitor

Obrigado por considerar contribuir! 🎉

## 🤝 Como Contribuir

### Reportar Bugs
1. Verifique se o bug já não foi reportado
2. Abra uma Issue com:
   - Descrição clara do problema
   - Passos para reproduzir
   - Versão do Minecraft, CC:Tweaked e SecurityCraft
   - Screenshots (se aplicável)

### Sugerir Funcionalidades
1. Abra uma Issue descrevendo:
   - O que você gostaria de ver
   - Por que seria útil
   - Como deveria funcionar

### Enviar Pull Requests

#### Setup do Ambiente
```bash
git clone https://github.com/[seu-usuario]/[repo].git
cd [repo]
```

#### Workflow
1. Fork o projeto
2. Crie uma branch:
   ```bash
   git checkout -b feature/minha-funcionalidade
   ```
3. Faça suas alterações
4. Teste no Minecraft
5. Commit:
   ```bash
   git commit -m "feat: adiciona nova funcionalidade"
   ```
6. Push:
   ```bash
   git push origin feature/minha-funcionalidade
   ```
7. Abra um Pull Request

## 📋 Checklist do PR

- [ ] Testado no Minecraft
- [ ] Código comentado
- [ ] Sem erros de sintaxe Lua
- [ ] Documentação atualizada
- [ ] Funciona com múltiplas câmeras

## 🎨 Estilo de Código

### Lua Style Guide
```lua
-- Use camelCase para variáveis
local cameraList = {}

-- Use PascalCase para constantes
local MAX_CAMERAS = 10

-- Comente funções importantes
-- Retorna lista de câmeras conectadas
local function scanCameras()
    -- implementação
end

-- Indentação: 4 espaços
if condition then
    doSomething()
end
```

## 🧪 Testes

Antes de enviar:
1. Teste com 1 câmera
2. Teste com múltiplas câmeras (5+)
3. Teste desconexão de câmeras
4. Teste em diferentes tamanhos de monitor

## 📝 Convenção de Commits

Use prefixos:
- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Documentação
- `style:` - Formatação
- `refactor:` - Refatoração
- `test:` - Testes
- `chore:` - Manutenção

Exemplos:
```
feat: adiciona suporte para câmeras infravermelhas
fix: corrige crash ao desconectar monitor
docs: atualiza guia de instalação
```

## 🐛 Debug

Para debug no Minecraft:
```lua
-- Adicione prints
print("Debug: " .. textutils.serialize(data))

-- Use pcall para capturar erros
local success, err = pcall(function()
    -- seu código
end)
if not success then
    print("Erro: " .. err)
end
```

## 📞 Dúvidas?

- Abra uma Discussion no GitHub
- Entre no Discord da comunidade

Obrigado por contribuir! 🚀
