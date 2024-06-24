# Como ter um var_dump personalizado?

```
<?php
// Função para formatar o var_dump
function prettyVarDump($variable) {
    echo '<pre style="
        background-color: #f9f9f9; 
        border: 1px solid #ccc; 
        padding: 10px; 
        margin: 10px 0; 
        font-size: 14px; 
        line-height: 1.4; 
        font-family: monospace; 
        color: #333;
        overflow: auto;
        white-space: pre-wrap;
        word-wrap: break-word;
    ">';
    var_dump($variable);
    echo '</pre>';
}

/* Exemplo de uso da função
$data = [
    'name' => 'John Doe',
    'email' => 'john.doe@example.com',
    'roles' => ['admin', 'editor', 'subscriber'],
    'details' => [
        'age' => 30,
        'address' => '123 Main St',
        'city' => 'Anytown'
    ]
];
*/

// Chamando a função para exibir o var_dump formatado
prettyVarDump($data);
?>
```
