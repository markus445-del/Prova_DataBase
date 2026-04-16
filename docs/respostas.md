
Questão 1: SGBD Relacional

A escolha de um SGBD relacional como o PostgreSQL se justifica pela necessidade de garantir **integridade e consistência dos dados** em um sistema acadêmico.

As propriedades **ACID** asseguram:

* **Atomicidade:** operações completas ou revertidas
* **Consistência:** respeito às regras (PK, FK)
* **Isolamento:** evita conflitos simultâneos
* **Durabilidade:** persistência dos dados

Bancos NoSQL não garantem integridade referencial forte, o que pode comprometer dados críticos como notas e matrículas.

 Uso de Schemas
O uso de schemas (ex: `academico`, `seguranca`) é recomendado porque:
 Organiza o banco por domínio
 Permite controle de acesso mais seguro
 Facilita manutenção e escalabilidade
 Evita desorganização do schema `public`

Questão 5:
O Isolamento (ACID) garante que transações concorrentes não interfiram entre si.
Quando dois operadores tentam atualizar a mesma matrícula, o SGBD aplica um lock exclusivo na linha:
A primeira transação bloqueia o registro
A segunda fica em espera até o COMMIT ou ROLLBACK
Isso evita problemas como lost update e garante que o dado final permaneça consistente.


2: Modelo Logico ALUNOS (ra PK, nome, email, cidade, ativo)
PROFESSORES (id_professor PK, nome, ativo)
DISCIPLINAS (cod_disciplina PK, nome, carga_horaria, id_professor FK, ativo)
MATRICULAS (id_matricula PK, ra FK, cod_disciplina FK, nota, data_matricula, ciclo, ativo)

       DER         +----------------------+
                |    PROFESSORES       |
                +----------------------+
                | PK id_professor      |
                | nome                 |
                | ativo                |
                +----------------------+
                         |
                         | 1
                         |
                         | N
                +----------------------+
                |    DISCIPLINAS       |
                +----------------------+
                | PK cod_disciplina    |
                | nome                 |
                | carga_horaria        |
                | FK id_professor      |
                | ativo                |
                +----------------------+
                         |
                         | 1
                         |
                         | N
                +----------------------+
                |    MATRICULAS        |
                +----------------------+
                | PK id_matricula      |
                | FK ra                |
                | FK cod_disciplina    |
                | nota                 |
                | data_matricula       |
                | ciclo                |
                | ativo                |
                +----------------------+
                         ^
                         |
                         | N
                         |
                         | 1
                +----------------------+
                |      ALUNOS          |
                +----------------------+
                | PK ra                |
                | nome                 |
                | email                |
                | cidade               |
                | ativo                |
                +----------------------+