# Trakting
Trakt"ting", app para iOS, escrito em Swift, usando API Trakt.tv.

#### Requisitos para executar este projeto

* Xcode 11
* iOS SDK 11
* Cocoapods 1.8.4

#### Instruções 
* Na raiz do projeto, deve-se executar o comoando, via Terminal: `pod install`
* Abrir o arquivo `Trakting.xcworkspace` no Xcode para build/run

#### Checklist

* ✔︎ Uma lista das séries que ele está assistindo no momento;<br>
* ✔︎ A informação de quantos por cento da séria já foi concluída;<br>
* ✔︎ Qual o próximo episódio (e a data);<br>
* ✔︎ Uma página com as informações dos episódios (só dos próximos, só do último ou de todos fica a seu critério); <br>
* ✔︎ Marcar como assistido um episódio;<br>
* ✕ O Pedro é exigente e vai olhar primeiro os testes. <br>
* ✔︎ Tela do perfil;<br>
* ✔︎ Possibilidade de buscar séries; <br>
* ✔︎ Adicionar uma série na watch list. <br>
* ✔︎ E como bônus, algumas das funcionalidades implementadas podem ser acessíveis offline. <br>

#### DIRETIVAS NESTE PROJETO

* VIPER
* ViewCode
* Priorizar solução nativas (frameworkds, apis, ...)
* Tendencionar a Layers, CleanCode, Solid, ...

#### TODO BASEADO NAS DIRETIVAS

* Substituir libs de terceiros por soluções próprias
* Criar camada DataLayer como um framework, para reaproveitamento em outras plataformas (watch, pad, tv, mac)
  * Criar repositories
  * Substituir API (TraktKit) por uma própria
  * Substituir Cache por persistencia via CoreData
* Escrever Tests
