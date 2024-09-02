![Maintained YES](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square&color=important)
![Memory Leak Verified YES](https://img.shields.io/badge/Memory%20Leak%20Verified%3F-yes-green.svg?style=flat-square&color=important)
![Release](https://img.shields.io/github/v/release/antoniojmsjr/RESTClientLib?label=Latest%20release&style=flat-square&color=important)
![Stars](https://img.shields.io/github/stars/antoniojmsjr/RESTClientLib.svg?style=flat-square)
![Forks](https://img.shields.io/github/forks/antoniojmsjr/RESTClientLib.svg?style=flat-square)
![Issues](https://img.shields.io/github/issues/antoniojmsjr/RESTClientLib.svg?style=flat-square&color=blue)</br>
![Compatibility](https://img.shields.io/badge/Compatibility-VCL,%20Firemonkey-3db36a?style=flat-square)
![Delphi Supported Versions](https://img.shields.io/badge/Delphi%20Supported%20Versions-Seattle%20and%20higher-3db36a?style=flat-square)

</br>
<p align="center">
  <a href="https://github.com/antoniojmsjr/RESTClientLib/blob/main/Image/Logo.png">
    <img alt="IPGeolocation" height="120" width="600" src="https://github.com/antoniojmsjr/RESTClientLib/blob/main/Image/Logo.png">
  </a>
</p>
</br>

# RESTClientLib

**RESTClientLib** é uma biblioteca projetada para facilitar a integração e consulta a APIs REST, é uma solução completa e versátil para quem precisa realizar integrações REST de maneira eficiente e sem complicações.

Implementado na linguagem `Delphi`, utiliza o conceito de [fluent interface](https://en.wikipedia.org/wiki/Fluent_interface) para guiar no uso da biblioteca, desenvolvida para oferecer praticidade e eficiência, a RESTClientLib oferece suporte aos principais motores de requisição, como Indy, NetHTTP e Synapse, expansível a outros motores.

Essa biblioteca é ideal para desenvolvedores Delphi que buscam uma solução robusta, flexível e eficiente para integrar serviços REST em suas aplicações.

#### Recursos

* Facilidade de Integração: Com uma interface intuitiva e fácil de usar, a RESTClientLib torna o processo de integrar APIs REST em aplicações Delphi mais rápido e eficiente.
* Economia de Tempo: Com a RESTClientLib, desenvolvedores podem se concentrar na lógica de aplicação, economizando tempo no desenvolvimento e integração com APIs.
* Compatibilidade: Projetada para ser compatível com várias versões do Delphi, a RESTClientLib oferece suporte tanto para aplicativos legados quanto para novas implementações.
* Motores de Requisição: Com suporte a Indy, NetHTTP e Synapse, a RESTClientLib permite que os desenvolvedores escolham o motor mais adequado às suas necessidades específicas, proporcionando maior flexibilidade e controle sobre o comportamento das requisições.
* Manipulação de Erros e Exceções: A biblioteca inclui um sistema robusto de manipulação de erros, com mensagens claras e tratativas de exceções que ajudam a depurar problemas durante a comunicação com APIs.
* Exemplos de uso: Repositório com diversos exemplos de uso da biblioteca, por exemplo, VCL, FMX e um servidor de aplicação em [Horse](https://github.com/HashLoad/horse).

#### Motores de Requisição
> [!WARNING]\
Para selecionar o motor na requisição é disponibilizado o tipo `TRESTClientLibRequestLibraryKind`, sendo o motor `NetHTTP` o padrão da biblioteca.

| Motor | Tipo | Diretiva de Compilação | Site |
|---|---|---|---|
| NetHTTP | TRESTClientLibRequestLibraryKind.NetHTTP | -- |  -- | 
| Indy | TRESTClientLibRequestLibraryKind.Indy | -- | -- | 
| Synapse | TRESTClientLibRequestLibraryKind.Synapse | RESTClientLib_SYNAPSE | http://synapse.ararat.cz/doku.php/start |

```delphi
Uses
  RESTClientLib;
begin
  TRESTClientLib
    .Build(TRESTClientLibRequestLibraryKind.NetHTTP);
  ...
end;
```

## ⚙️ Instalação Automatizada

Utilizando o [**Boss**](https://github.com/HashLoad/boss/releases/latest) (Dependency manager for Delphi) é possível instalar a biblioteca de forma automatizada.

```
boss install https://github.com/antoniojmsjr/RESTClientLib
```

## ⚙️ Instalação Manual

Se você optar por instalar manualmente, basta adicionar as seguintes pastas ao seu projeto, em *Project > Options > Delphi Compiler > Target > All Configurations > Search path*

```
..\RESTClientLib\Source
```

## ⚡️ Uso da biblioteca

Os exemplos estão disponíveis na pasta do projeto:

```
..\RESTClientLib\Samples
```

