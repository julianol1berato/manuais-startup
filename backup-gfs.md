# Estratégia de Backup GFS (Grandfather-Father-Son)

## Introdução

Esta estratégia de backup GFS (Grandfather-Father-Son) é projetada para garantir a proteção e a recuperação eficiente dos dados críticos da organização. A política inclui backups incrementais diários, completos semanais, completos mensais e completos anuais, com retenção adequada para cada tipo de backup e expiração de dados antigos.

## Objetivo

Garantir a segurança e a disponibilidade dos dados da empresa através de uma estratégia de backup que balanceia a eficiência de armazenamento com a rapidez de recuperação.

## Tipos de Backup

1. **Backup Incremental Diário (Filho)**:
   - **Descrição**: Captura apenas as mudanças desde o último backup (completo ou incremental).
   - **Frequência**: Diariamente, exceto no dia do backup completo semanal.
   - **Retenção**: 1 semana.
   - **Expiração**: 7 dias após a criação.

2. **Backup Completo Semanal (Pai)**:
   - **Descrição**: Captura todos os dados.
   - **Frequência**: Uma vez por semana.
   - **Retenção**: 4 semanas.
   - **Expiração**: 4 semanas após a criação.

3. **Backup Completo Mensal (Avô)**:
   - **Descrição**: Captura todos os dados.
   - **Frequência**: Uma vez por mês.
   - **Retenção**: 12 meses.
   - **Expiração**: 12 meses após a criação.

4. **Backup Completo Anual (Bisavô)**:
   - **Descrição**: Captura todos os dados.
   - **Frequência**: Uma vez por ano.
   - **Retenção**: 3 anos.
   - **Expiração**: 3 anos após a criação.

## Volumetria de Backup com Crescimento Vegetativo

### Crescimento Vegetativo

- **Crescimento Mensal**: 2%
- **Crescimento Anual**: Aproximadamente 26.82% (composto mensalmente)

### Estimativas Anuais

1. **Backup Completo Inicial**: 
   - **Tamanho Inicial**: 500GB

2. **Backup Completo Semanal**:
   - **Tamanho Inicial**: 500GB
   - **Frequência**: 52 vezes por ano
   - **Crescimento Mensal**: Aplicado a cada mês
   - **Volumetria Anual**: Aproximadamente 29.46TB

3. **Backup Completo Mensal**:
   - **Tamanho Inicial**: 500GB
   - **Frequência**: 12 vezes por ano
   - **Volumetria Anual**: Aproximadamente 7.95TB

4. **Backup Completo Anual**:
   - **Tamanho Inicial**: 500GB
   - **Frequência**: 1 vez por ano
   - **Volumetria Anual**: 0.5TB

5. **Backup Incremental Diário**:
   - **Tamanho Incremental Inicial**: 10% dos dados totais por dia
   - **Volumetria Anual**: Aproximadamente 25.09TB

### Volumetria Total Anual

\[29.46TB + 7.95TB + 0.5TB + 25.09TB = 62.99TB\]

### Projeção de 3 Anos

- **Volumetria Anual**: 62.99TB
- **Total para 3 Anos**: Aproximadamente 188.97TB

## Procedimentos de Backup

### Backup Incremental Diário

- **Configuração**: Configurar backups incrementais diários automáticos, exceto no dia do backup completo semanal.
- **Verificação**: Verificar a integridade dos backups diariamente.

### Backup Completo Semanal

- **Configuração**: Agendar backups completos semanais automáticos.
- **Verificação**: Verificar a integridade dos backups semanalmente.

### Backup Completo Mensal

- **Configuração**: Agendar backups completos mensais automáticos.
- **Verificação**: Verificar a integridade dos backups mensalmente.

### Backup Completo Anual

- **Configuração**: Agendar backups completos anuais automáticos.
- **Verificação**: Verificar a integridade dos backups anualmente.

## Recuperação de Dados

1. **Backup Incremental Diário**:
   - Restaurar o backup completo mais recente e aplicar os incrementais diários subsequentes.

2. **Backup Completo Semanal**:
   - Restaurar o backup completo semanal mais recente.

3. **Backup Completo Mensal**:
   - Restaurar o backup completo mensal mais recente.

4. **Backup Completo Anual**:
   - Restaurar o backup completo anual mais recente.

## Monitoramento e Manutenção

- **Automatização**: Utilizar ferramentas de automação para agendamento e execução dos backups.
- **Monitoramento**: Implementar sistemas de monitoramento para garantir a execução e integridade dos backups.
- **Teste de Recuperação**: Realizar testes de recuperação regulares para garantir que os dados possam ser restaurados com sucesso.

## Segurança dos Dados

- **Criptografia**: Garantir que todos os backups sejam criptografados para proteger a confidencialidade dos dados.
- **Controle de Acesso**: Implementar controles de acesso rigorosos para garantir que apenas pessoal autorizado possa acessar os backups.

## Revisão da Política

Esta política de backup deve ser revisada e atualizada anualmente ou conforme necessário para refletir mudanças na infraestrutura de TI ou nas necessidades de negócios.

## Conclusão

A estratégia de backup GFS com retenções e expiração proporciona um equilíbrio eficiente entre armazenamento e recuperação rápida, garantindo a proteção contínua dos dados críticos da empresa.
