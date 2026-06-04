-- =====================================
-- EXERCÍCIO 1A - SUBQUERY SCALAR
-- =====================================

SELECT a.nome,
    (
        SELECT COUNT(*)
        FROM livro l
        WHERE l.id_autor = a.id_autor
    ) AS quantidade_livros,
    (
        SELECT ROUND(AVG(l.num_paginas))
        FROM livro l
        WHERE l.id_autor = a.id_autor
    ) AS media_paginas
FROM autor a;

-- =====================================
-- EXERCÍCIO 1B - CTE
-- =====================================

WITH dados_autor AS (
    SELECT
        id_autor,
        COUNT(*) AS quantidade_livros,
        ROUND(AVG(num_paginas), 2) AS media_paginas
    FROM livro
    GROUP BY id_autor
)
SELECT
    a.nome,
    d.quantidade_livros,
    d.media_paginas
FROM autor a
JOIN dados_autor d
    ON a.id_autor = d.id_autor;

-- =====================================
-- EXERCÍCIO 2
-- Listar autores cuja soma de páginas
-- ultrapassa a média geral
-- =====================================

WITH paginas_por_autor AS (
    SELECT a.id_autor, a.nome,
        SUM(l.num_paginas) AS total_paginas
    FROM autor a
    JOIN livro l ON a.id_autor = l.id_autor
    GROUP BY a.id_autor, a.nome
)
SELECT nome, total_paginas
FROM paginas_por_autor
WHERE total_paginas > (
    SELECT AVG(total_paginas)
    FROM paginas_por_autor
);

-- =====================================
-- EXERCÍCIO 3A
-- Subconsulta correlacionada
-- =====================================

SELECT
    a.nome,
    (
        SELECT COUNT(*)
        FROM livro l
        WHERE l.id_autor = a.id_autor
    ) AS quantidade_livros
FROM autor a;

-- =====================================
-- EXERCÍCIO 3B
-- CTE pré-agrupada
-- =====================================

WITH livros_por_autor AS (
    SELECT
        id_autor,
        COUNT(*) AS quantidade_livros
    FROM livro
    GROUP BY id_autor
)
SELECT
    a.nome,
    l.quantidade_livros
FROM autor a
JOIN livros_por_autor l
    ON a.id_autor = l.id_autor;