---
title: Implementando Interesses Transversais - um papo sobre
arquitetura, DI e Design Patterns em Swift/iOS
author: Cícero Camargo (CODEMUS)
date: Nov 30th 2021
---






# Vamos começar pelo código 

Commit: `805f75891deccfc17da35e3ddd4b6d82a4e6bd0e`.













# O que são Interesses Transversais?

Interesses Transversais (ou Cross-cutting Concerns) são, basicamente,
trechos de código que não implementam Interesses de Negócio. 

Exemplos:

* Tracking
* Caching
* Threading
* Logging
* Medição de Performance, etc.














# Aspect Oriented Programming

Um conjunto de técnicas e ferramentas para implementar Aspectos (wrappers de
Interesses Transversais).

A ideia é:

1. Extrair os Interesses Transversais para módulos separados
2. Integrá-los aos Interesses de Negócio por meio de *Interceptação* de chamadas;

É muito popular em Java, mas dá para fazer em Swift? Sim! Como?
* Method Swizzling 😅 (Hello Firebase, Facebook, etc.)
* Código bem fatorado 😎 (principalmente com o uso do *Decorator Pattern*) 














# Bora melhorar esse código?
- Threading (Decorator)
- Caching (Decorator)
- Tracking (Command + Observer)
















# Valeu!

email: camargo.cicero@gmail.com
youtube: Cícero Camargo CODEMUS
instagram: cicerocamargo.dev
twitter: cicerocamargo
linkedin: linkedin.com/in/cicerocamargo












