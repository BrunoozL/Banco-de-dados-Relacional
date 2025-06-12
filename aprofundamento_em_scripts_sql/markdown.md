# APROFUNDAMENTO EM SCRIPTS SQL

## Item 1: Tipos de JOIN
### CONCEITO:
 - `INNER JOIN`: Retorna apenas os registros que possuem correspondência entre as duas tabelas
 - `LEFT JOIN`: Retorna todos os registros da tabela da esquerda e os correspondentes da tabela da direita. Se não houver correspondência, os campos da tabela da direita vêm como NULL
 - `RIGHT JOIN`: Retorna todos os registros da tabela da direita e os correspondentes da esquerda. Se não houver correspondência, os campos da tabela da esquerda vêm como NULL

### 🔹 Desafio 1 – INNER JOIN: Pagamentos e Clientes
```sql
-- Situação-problema: A equipe financeira quer gerar um relatório com os pagamentos realizados, mostrando quem foram os clientes que efetuaram esses pagamentos. Eles precisam do valor pago, a data e o nome do cliente para cada registro.

-- Objetivo técnico: Crie uma consulta SQL que mostre o nome completo dos clientes (first_name e last_name), o valor pago (amount) e a data do pagamento (payment_date).

SELECT
    c.first_name AS 'NOME', 
    c.last_name AS 'SOBRENOME', 
    p.amount AS 'VALOR', 
    p.payment_date AS 'DATA_PAGAMENTO'
FROM customer c
INNER JOIN payment p WHERE c.customer_id = p.customer_id;
```

### 🔸 Desafio 2 – LEFT JOIN: Inventário sem Aluguel
```sql
-- Situação-problema: A equipe da loja quer identificar quais cópias de filmes (itens do inventário) ainda não foram alugadas nenhuma vez. Essa análise ajudará a detectar filmes recém-adicionados que ainda não tiveram saída.

-- Objetivo técnico: Crie uma consulta SQL que liste os IDs de inventário (inventory_id) e os IDs dos filmes (film_id) que ainda não possuem nenhum aluguel registrado.

SELECT 
    i.inventory_id AS 'ID_INVENTARIO',
    i.film_id AS 'ID_FILME'
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id WHERE r.rental_id IS NULL;
```


## Item 2: Múltiplos JOINs
### CONCEITO:
- O SQL junta duas tabelas de cada vez com base em uma condição (ON).
- O resultado dessa junção é tratado como uma nova tabela temporária.
- Depois, o SQL pega essa tabela intermediária e a junta com a próxima tabela.
- Isso continua até todas as tabelas estarem conectadas.

### 🔹 Desafio 1 – INNER JOIN: Relatório de Aluguéis com Informações de Clientes
```sql
-- Situação-problema: A equipe de marketing deseja uma lista de todos os aluguéis realizados, incluindo o nome completo do cliente, a data do aluguel e o título do filme alugado. Essas informações serão usadas para personalizar campanhas de e-mail.

-- Objetivo técnico: Use INNER JOIN para combinar dados das tabelas rental, inventory, film e customer.

SELECT 
    c.first_name AS 'NOME',
    c.last_name AS 'SOBRENOME',
    r.rental_date AS 'DATA_ALUGUEL',
    f.title AS 'FILME'
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id;
```

### 🔸 Desafio 2 – Funcionários e Filmes Alugados por Loja
```sql
-- Situação-problema: A gerência deseja saber quais filmes foram alugados por cada funcionário, em qual loja isso ocorreu, para avaliar o desempenho por unidade.

-- Objetivo técnico: Crie um relatório que mostre nome do funcionário (completo), loja, título do filme alugado e data do aluguel

SELECT 
    s.first_name AS 'FUNC_NOME',
    s.last_name AS 'FUNC_SOBRENOME',
    s.store_id AS 'LOJA',
    f.title AS 'FILME',
    r.rental_date AS 'DATA_ALUGUEL'
FROM staff s
INNER JOIN rental r ON r.staff_id = s.staff_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id;
```


## Item 3: Funções na Cláusula SELECT
### CONCEITO:
🔤 Funções de Texto
- `CONCAT`: Une duas ou mais strings em uma só.
- `CONCAT_WS`: Une strings com um separador definido (ex: espaço, vírgula, hífen).
- `UPPER`: Converte todo o texto para letras maiúsculas.
- `LOWER`: Converte todo o texto para letras minúsculas.
- `SUBSTRING`: Retorna parte de uma string, a partir de uma posição e com tamanho definido.
- `LENGTH`: Retorna o número de caracteres (ou bytes) em uma string.
- `REPLACE`: Substitui partes de um texto por outro valor.

🔢 Funções Numéricas
- `ROUND`: Arredonda um número para o número de casas decimais desejado.
- `CEIL`: Arredonda o número para cima (valor inteiro maior ou igual).
- `FLOOR`: Arredonda o número para baixo (valor inteiro menor ou igual).

❓ Funções para Tratamento de Nulos
- `COALESCE`: Retorna o primeiro valor não nulo de uma lista de opções.
- `IFNULL`: Retorna o valor original, ou um valor alternativo se for NULL.


### 🔷 Desafio 1 – Manipulação e Concatenação de Strings
```sql
-- Situação-problema: A equipe de atendimento deseja criar uma saudação personalizada para cada cliente cadastrado no sistema, a ser utilizada em mensagens automáticas.

-- Objetivo técnico: Utilizar apenas a função de concatenação de strings (CONCAT) para montar o nome completo do cliente e apresentá-lo em um formato legível.

SELECT CONCAT('Bem vindo(a)!: ', first_name, ' ', last_name) AS 'SAUDACAO'
FROM customer;
```

### 🔸 Desafio 2 – Tratamento de Valores Nulos e Arredondamento
```sql
-- Situação-problema: O setor financeiro quer garantir que todos os valores de pagamento estejam corretamente formatados. Alguns valores podem estar ausentes (NULL) e devem ser tratados como zero, com todos os valores exibidos com apenas duas casas decimais.

-- Objetivo técnico: Utilizar as funções IFNULL (ou COALESCE) para substituir valores nulos e ROUND para arredondar os valores para duas casas decimais.

SELECT payment_id AS 'ID_PAGAMENTO', ROUND(IFNULL(amount, 0), 2) AS 'VALOR_FORMATADO'
FROM payment;
```


## Item 4: Funções de Data e Hora
### CONCEITO:
- `NOW`: Retorna a data e hora atuais do sistema.
- `CURDATE`: Retorna apenas a data atual, sem a hora.
- `DATE_FORMAT`: Formata uma data/hora de acordo com o padrão especificado.
- `DATEDIFF`: Calcula a diferença em dias entre duas datas.
- `DAY`: Extrai o dia do mês de uma data.
- `MONTH`: Extrai o mês de uma data.
- `YEAR`: Extrai o ano de uma data.
- `DATE_ADD`: Adiciona um intervalo de tempo (dias, meses, anos etc.) a uma data.
- `DATE_SUB`: Subtrai um intervalo de tempo de uma data.

### 🔷 Desafio 1 – Cálculo de Intervalos entre Datas
```sql
--Situação-problema: O setor de logística quer calcular quantos dias os filmes permanecem alugados para entender o tempo médio de locação e melhorar a gestão dos prazos.

--Objetivo técnico: Calcular o número de dias entre a data do aluguel (rental_date) e a data de devolução (return_date) na tabela rental.

SELECT rental_id AS 'ID_ALUGUEL', DATEDIFF(return_date, rental_date) AS 'DIAS_DE_ALUGUEL'
FROM rental;
```

### 🔸 Desafio 2 – Formatação de Datas no Formato 'dd/mm/yyyy'
```sql
-- Situação-problema: A equipe financeira precisa que as datas dos pagamentos sejam exibidas em relatórios no formato dd/mm/yyyy, para facilitar a leitura e conformidade com padrões locais.

-- Objetivo técnico: Formatar a coluna payment_date da tabela payment para o padrão brasileiro dd/mm/yyyy.

SELECT payment_id AS 'ID_PAGAMENTO', DATE_FORMAT(payment_date, '%d/%m/%Y') AS 'DATA_FORMATADA'
FROM payment;
```


## Item 5: Subconsultas (Subqueries)
### CONCEITO:
- Subconsultas: Consultas SQL dentro de outra consulta maior, usadas para buscar dados que ajudam a filtrar, calcular ou comparar resultados.
- Subconsulta escalar: Retorna um único valor (uma linha e uma coluna), usada quando se espera um resultado único.
- Subconsulta de múltiplas linhas: Retorna várias linhas, usada com operadores como IN, ANY ou ALL para comparar vários valores.
- Subconsulta correlacionada: Depende da consulta externa, usando valores dela para executar e é avaliada para cada linha da consulta externa.

### 🔷 Desafio 1 – Subconsulta Simples com IN
```sql
-- Situação-problema: O gerente quer listar todos os clientes que realizaram pelo menos um pagamento. Para isso, precisamos buscar os clientes cujo customer_id aparece na tabela de pagamentos.

-- Objetivo técnico: Usar uma subconsulta simples com IN no WHERE para filtrar os clientes que têm pagamentos registrados.

SELECT first_name AS 'NOME', last_name AS 'SOBRENOME'
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment);
```

### 🔸 Desafio 2 – Subconsulta Correlacionada Simples
```sql
-- Situação-problema: Queremos listar os clientes que já fizeram pelo menos um aluguel.

-- Objetivo técnico: Usar uma subconsulta correlacionada no WHERE EXISTS para filtrar clientes com aluguel.

SELECT c.customer_id AS 'ID_CLIENTE', c.first_name AS 'NOME', c.last_name AS 'SOBRENOME'
FROM customer c
WHERE EXISTS (SELECT 1 FROM rental r WHERE r.customer_id = c.customer_id);
```


## Item 6: Subconsultas em Comandos DML
### CONCEITO:
- `SELECT` como fonte de dados: O resultado de uma consulta `SELECT` pode ser usado para inserir dados em outra tabela usando `INSERT INTO ... SELECT`, permitindo copiar ou transformar dados em massa.
- `SELECT` como critério de filtro no `UPDATE`: Em um `UPDATE`, uma subconsulta `SELECT` pode ser usada na cláusula `WHERE` para definir condições complexas que determinam quais registros serão atualizados.
- `SELECT` como critério de filtro no `DELETE`: De forma similar, no `DELETE`, uma subconsulta `SELECT` pode filtrar quais registros devem ser apagados, possibilitando exclusões baseadas em critérios derivados de outras tabelas ou consultas.
- Manipulação em massa: Essa combinação permite executar operações em grandes volumes de dados com base em análises e relações complexas, sem precisar manipular registro por registro manualmente.

### 🔷 Desafio 1 – UPDATE com EXISTS
```sql
-- Situação-problema: A equipe de cadastro decidiu marcar com um endereço especial todos os clientes que já fizeram pelo menos um pagamento, para diferenciar clientes ativos.

-- Objetivo técnico: Usar UPDATE com EXISTS para identificar e alterar os registros de clientes que possuem pelo menos um pagamento registrado.

SET SQL_SAFE_UPDATES = 0; -- DESABILITANDO SAFE MODE

UPDATE customer c
SET address_id = 10
WHERE EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id);
```

### 🔸 Desafio 2 – DELETE com EXISTS
```sql
-- Situação-problema: A equipe de TI precisa remover todos os registros de clientes que já foram apagados da tabela principal, mas ainda existem na tabela rental (simulando dados órfãos).

-- Objetivo técnico: Usar DELETE com EXISTS para apagar registros da tabela rental cujos customer_id não existem mais na tabela customer.

DELETE FROM rental
WHERE NOT EXISTS (SELECT 1 FROM customer WHERE customer.customer_id = rental.customer_id);
```


## Item 7: WITH AS (CTE) e DISTINCT
### CONCEITO: 
- `DISTINCT`: Remove linhas duplicadas do resultado de uma consulta, retornando apenas combinações únicas dos valores selecionados. É útil quando você quer evitar repetições nos dados retornados por colunas individuais ou por conjuntos de colunas.
- `WITH` (CTE – Common Table Expression): Permite criar uma consulta temporária nomeada, que pode ser referenciada logo abaixo, como se fosse uma tabela. Ela melhora a organização e legibilidade de scripts complexos, além de evitar repetições de subconsultas.

### 🔹 Desafio 1 – Contagem Única com DISTINCT
```sql
-- Situação-problema: Queremos saber o número total de cidades diferentes cadastradas na tabela de endereços.

-- Objetivo técnico: Usar DISTINCT para contar cidades únicas diretamente na tabela address, sem juntar com outras tabelas.

SELECT COUNT(DISTINCT city_id) AS 'TOTAL_CIDADES'
FROM address;
```

### 🔸 Desafio 2 – Listar Todos os Clientes com o Número do Endereço
```sql
-- Situação-problema: O time de cadastro quer um relatório rápido com todos os clientes e seus respectivos IDs de endereço.

-- Objetivo técnico: Usar uma CTE (WITH AS) para selecionar clientes com seus address_id, sem usar GROUP BY ou joins.

WITH clientes_enderecos AS 
(SELECT 
    customer_id AS 'ID_CLIENTE', 
    first_name AS 'NOME', 
    last_name AS 'SOBRENOME', 
    address_id AS 'ID_ENDERECO' 
FROM customer)
SELECT * FROM clientes_enderecos;
```


## Item 8: Funções de Janela (Window Functions) para Ranking
### CONCEITO:
- Window Functions: Funções que fazem cálculos sobre um conjunto de linhas relacionadas à linha atual, sem agrupar os resultados em uma única linha, permitindo análises detalhadas dentro do contexto da consulta.
- `OVER()`: Cláusula que define a “janela” de linhas sobre a qual a função será aplicada, podendo incluir partições (`PARTITION BY`) e ordenações (`ORDER BY`).
- `ROW_NUMBER()`: Atribui um número sequencial único para cada linha dentro da partição, sem considerar empates — cada linha tem um número distinto.
- `RANK()`: Gera uma classificação que pode pular números em caso de empate. Linhas com valores iguais recebem a mesma posição, e a próxima posição “pula” os números correspondentes.
- `DENSE_RANK()`: Semelhante ao `RANK()`, mas não pula números após empates. Linhas empatadas têm a mesma posição, e a próxima linha recebe a posição seguinte direta.

### 🔹 Desafio 1 – Ranking de Pagamentos Individuais
```sql
-- Situação-problema: A equipe quer identificar os pagamentos mais altos já realizados pelos clientes, listando os maiores em ordem.

-- Objetivo técnico: Usar DENSE_RANK() para ordenar os pagamentos da tabela payment.

SELECT 
	c.first_name AS 'NOME',
    c.last_name AS 'SOBRENOME',
    p.payment_id AS 'ID_PAGAMENTO',
    p.amount AS 'QUANTIA',
    DENSE_RANK() OVER (ORDER BY amount DESC) 'RANK'
FROM payment p
INNER JOIN customer c ON c.customer_id = p.customer_id;
```

### 🔸 Desafio 2 – Ranking de Datas de Aluguel
```sql
-- Situação-problema: Precisamos saber quais foram os primeiros aluguéis registrados no sistema.

-- Objetivo técnico: Usar ROW_NUMBER() para criar um ranking das datas de aluguel.

SELECT 
    rental_id AS 'ID_ALUGUEL',
    rental_date AS 'DATA_ALUGUEL',
    ROW_NUMBER() OVER (ORDER BY rental_date) 'RANK'
FROM rental;
```


## Item 9: Lógica Condicional com CASE
### CONCEITO:
- `CASE` `WHEN` ... `THEN` ... `ELSE` ... `END`: Estrutura que permite aplicar lógica condicional (estilo `IF/THEN/ELSE`) dentro de consultas SQL. É usada para criar colunas com valores derivados de condições, permitindo transformar dados dinamicamente com base em regras específicas.

### 🔹 Desafio 1 – Classificação de Filmes por Duração
```sql
-- Situação-problema: O setor de marketing quer classificar os filmes por duração para facilitar recomendações rápidas: curtos, médios ou longos.

-- Objetivo técnico: Criar uma nova coluna classificando a duração (length) dos filmes com base em faixas.

SELECT 
    title AS 'TITULO',
    length AS 'TEMPO',
    CASE
        WHEN length > 120 THEN 'Longo'
        WHEN length >= 60 THEN 'Medio'
    ELSE 'Curto'
    END AS 'DURACAO'
FROM film;
```

### 🔸 Desafio 2 – Classificação de Clientes por Atividade
```sql
-- Situação-problema: A equipe de CRM quer categorizar os clientes como "ativos" ou "inativos" com base em seu status de conta.

-- Objetivo técnico: Adicionar uma coluna que classifica o cliente com base no valor de active.

SELECT 
    customer_id AS 'ID_CLIENTE',
    first_name AS 'NOME',
    last_name AS 'SOBRENOME',
    CASE
        WHEN active = 1 THEN 'Ativo'
        ELSE 'Inativo'
    END AS 'STATUS'
FROM customer;
```


## Item 10: Combinando Resultados com UNION
### CONCEITO:
- `UNION`: Combina os resultados de duas ou mais consultas `SELECT`, removendo linhas duplicadas no resultado final. É útil quando você quer uma lista única de dados combinados.
- `UNION ALL`: Também combina os resultados de múltiplas consultas `SELECT`, mas mantém todas as linhas, inclusive as duplicadas. Por isso, é geralmente mais rápido do que `UNION`, já que não precisa processar a remoção de duplicatas.

### 🔹 Desafio – Lista Unificada de Nomes de Atores e Clientes
```sql
-- Situação-problema: O time de comunicação quer disparar uma campanha de marketing com nomes personalizados. Para isso, precisa de uma lista única contendo nomes de atores e clientes, independentemente da origem.

-- Objetivo técnico: Usar UNION para combinar os nomes da tabela actor e da tabela customer em uma única lista.

SELECT first_name AS 'NOME', last_name AS 'SOBRENOME' FROM customer
UNION
SELECT first_name, last_name FROM actor;
```


## Item 11: Visões (Views)
### CONCEITO:
- Views: São “tabelas virtuais” baseadas no resultado de uma consulta `SELECT`. Elas não armazenam dados fisicamente, apenas representam dados existentes em uma ou mais tabelas de forma personalizada.

Vantagens:
- Simplificação: Permite encapsular consultas complexas e reutilizá-las como se fossem tabelas simples.
- Reutilização de código: Evita repetir longas instruções SQL em diferentes partes do sistema.
- Segurança: Restringe o acesso direto às tabelas base, exibindo apenas os dados necessários ao usuário ou aplicação.

### 🔹 Desafio – Criar e Utilizar uma VIEW para Relatório de Aluguéis
```sql
-- Situação-problema: O setor financeiro precisa consultar frequentemente dados combinados de clientes, filmes e datas de aluguel. Para facilitar, a equipe de dados quer criar uma VIEW reutilizável com essas informações.

-- Objetivo técnico: Criar uma VIEW que contenha nome do cliente, título do filme e data do aluguel e consultar essa VIEW para buscar todos os aluguéis de um cliente específico.

CREATE VIEW aluguel_do_cliente AS
SELECT 
    c.first_name AS 'NOME',
    c.last_name AS 'SOBRENOME',
    f.title AS 'FILME',
    r.rental_date AS 'DATA_ALUGUEL'
FROM rental r
INNER JOIN customer c ON c.customer_id = r.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id;

SELECT * FROM aluguel_do_cliente
WHERE NOME = 'MARY' AND SOBRENOME = 'SMITH';
```


## Item 12: Filtragem com WHERE vs. HAVING
### CONCEITO:
- `WHERE`: Filtra linhas individuais antes de qualquer agrupamento (`GROUP BY`). É usado para limitar quais registros entram na agregação ou no restante da consulta.
- `HAVING`: Filtra os grupos de linhas após o `GROUP BY` e as funções de agregação (`COUNT`, `SUM`, etc.). Serve para aplicar condições sobre os resultados agregados.

### 🔹 Desafio – Clientes com Alto Volume de Alugueis
```sql
-- Situação-problema: A equipe de relacionamento quer identificar clientes muito ativos, ou seja, que já realizaram mais de 30 aluguéis. Essa lista será usada para oferecer benefícios exclusivos.

-- Objetivo técnico: Agrupar os dados da tabela rental por cliente e usar HAVING para filtrar somente aqueles com mais de 30 registros.

SELECT
    r.customer_id AS 'ID_CLIENTE', 
    c.first_name AS 'NOME', 
    c.last_name AS 'SOBRENOME', 
    COUNT(*) AS 'TOTAL_ALUGUEL'
FROM rental r
INNER JOIN customer c WHERE c.customer_id = r.customer_id
GROUP BY r.customer_id
HAVING COUNT(*) > 30;
```


## Item 13: Controle de Transações (COMMIT e ROLLBACK)
### CONCEITO:
- Transação: É um conjunto de operações SQL que devem ser executadas como uma unidade atômica, ou seja, tudo ou nada. Se todas as operações forem bem-sucedidas, os dados são salvos; se ocorrer algum erro, nada é aplicado. Isso garante consistência, integridade e controle das alterações no banco de dados.
- `START TRANSACTION`: Inicia uma nova transação. A partir desse ponto, nenhuma alteração é efetivada até que haja um `COMMIT` ou `ROLLBACK`.
- `COMMIT`: Finaliza a transação e salva todas as alterações feitas no banco de dados.
- `ROLLBACK`: Cancela a transação e desfaz todas as alterações realizadas desde o `START TRANSACTION`.

### 🔹 Desafio – Registro de um Novo Aluguel com Atualização de Estoque
```sql
--- Situação-problema: Ao registrar um novo aluguel, é necessário garantir que o sistema:

-- -> Insira o novo aluguel na tabela rental,
-- -> Atualize o horário da última modificação na tabela inventory.

--- Como essas ações devem ocorrer juntas, precisam ser tratadas dentro de uma transação para manter a integridade dos dados (ou tudo ocorre, ou nada).

--- Objetivo técnico: Utilizar uma transação para garantir que o INSERT em rental e o UPDATE em inventory aconteçam de forma atômica.

START TRANSACTION;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (NOW(), 10, 2, 1);

UPDATE inventory SET last_update = NOW()
WHERE inventory_id = 10;

COMMIT;

-- Consultando para ver se deu certo:
SELECT 
	r.rental_date AS 'DATA_ALUGUEL',
	r.inventory_id AS 'ID_INVENTARIO',
	i.last_update AS 'ULTIMA_ATUALIZACAO'
FROM rental r 
INNER JOIN inventory i 
WHERE r.rental_date LIKE '2025%' AND i.last_update LIKE '2025%';
```

## Item 14: Gatilhos (Triggers)
### CONCEITO:
- `TRIGGER`: É um procedimento armazenado que é executado automaticamente toda vez que ocorre um evento específico (`INSERT`, `UPDATE` ou `DELETE`) em uma tabela.

Utilidade dos Triggers:
- Auditoria: Registrar automaticamente alterações feitas em uma tabela, como histórico de modificações ou quem fez cada mudança.
- Validação complexa: Impor regras de negócio que vão além das constraints tradicionais, antes de aceitar os dados.
- Replicação de dados: Copiar ou sincronizar dados entre tabelas (por exemplo, salvar um backup automático ao atualizar um registro).

### 🔹 Desafio – Registro de Atualizações em Filmes
```sql
-- Situação-problema: A equipe de segurança da informação deseja saber quem alterou e quando os dados de filmes são modificados, para fins de auditoria. Para isso, é necessário que qualquer alteração na tabela film seja registrada em uma tabela de log.

-- Objetivo técnico: Criar uma tabela de log e um TRIGGER que grave as alterações sempre que a tabela film for atualizada.

-- Criando a tabela log
CREATE TABLE log_film_update (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    film_id SMALLINT UNSIGNED,
    old_title VARCHAR(255),
    new_title VARCHAR(255),
    last_update DATETIME,
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- Criando o trigger para inserir na tabela log toda vez que houver atualização na tabela film
DELIMITER //
CREATE TRIGGER after_film_update
AFTER UPDATE ON film
FOR EACH ROW
BEGIN
    INSERT INTO log_film_update (film_id, old_title, new_title, last_update)
    VALUES (OLD.film_id, OLD.title, NEW.title, NOW());
END;
//
DELIMITER ;

-- Atualizando a tabela film
UPDATE film
SET title = 'ACADEMY DINOSAUR REMASTERED'
WHERE film_id = 1;

-- Mostrando a tabela log
SELECT * FROM log_film_update;
```

## Item 15: Índices e Otimização (Indexes)
### CONCEITO:
- Índice (`INDEX`): É uma estrutura de dados que acelera a busca de informações em uma tabela, especialmente quando ela é grande. Ele funciona como um atalho que permite ao banco de dados encontrar registros mais rapidamente, sem precisar varrer todas as linhas.

- Analogia com o livro:
Pense em um índice remissivo de um livro. Em vez de ler página por página até encontrar um capítulo, você vai direto ao índice, encontra a página desejada e acessa a informação em segundos.
No banco de dados, o índice faz o mesmo: aponta rapidamente onde está o dado que você quer.

- Vantagens:
Melhora velocidade de leitura em buscas, filtros (`WHERE`), ordenações (`ORDER BY`) e junções (`JOIN`). Muito útil em colunas que são frequentemente usadas em consultas complexas.

- Cuidado:
Índices ocupam espaço extra. Muitos índices podem afetar a performance de escrita (`INSERT`, `UPDATE`, `DELETE`), pois precisam ser atualizados.

### 🔹 Desafio - Criar uma consulta e um Índice para otimização
```sql
-- Situação-problema: A equipe de desenvolvimento precisa otimizar uma consulta que contém vários INNER JOINs

SELECT * FROM rental r
INNER JOIN customer c ON c.customer_id = r.customer_id
INNER JOIN store s ON s.store_id = c.store_id
INNER JOIN address a ON a.address_id = s.address_id
INNER JOIN city city ON city.city_id = a.city_id
INNER JOIN country country ON country.country_id = city.country_id;

CREATE INDEX idx_rental_customer_id ON rental(customer_id);
CREATE INDEX idx_customer_customer_id ON customer(customer_id);
CREATE INDEX idx_store_store_id ON store(store_id);
CREATE INDEX idx_address_address_id ON address(address_id);
CREATE INDEX idx_city_city_id ON city(city_id);
CREATE INDEX idx_country_country_id ON country(country_id);

-- NÃO VI NENHUMA DIFERENÇA
```