// ─────────────────────────────────────────────────────────────────
// 전총명 Portfolio — Typst
// 컴파일: typst compile portfolio.typ portfolio.pdf
// ─────────────────────────────────────────────────────────────────

#set page(
  paper: "a4",
  margin: (top: 1.4cm, bottom: 1.4cm, left: 1.7cm, right: 1.7cm),
)

#set text(
  font: ("Noto Sans CJK KR", "NanumGothic", "Apple SD Gothic Neo", "Noto Sans KR", "Noto Sans"),
  size: 9pt,
  lang: "ko",
  fill: rgb("#1f2328"),
)

#set par(leading: 0.70em, justify: false)
#set list(marker: [▸], body-indent: 0.55em)

#let CA  = rgb("#0969da")
#let CP  = rgb("#8250df")
#let CM  = rgb("#57606a")
#let CL  = rgb("#f6f8fa")
#let CB  = rgb("#d0d7de")
#let CG  = rgb("#1a7f37")
#let CY  = rgb("#9a6700")
#let CT  = rgb("#1f2328")

#let tag(body, col: CA) = box(
  fill:   col.lighten(88%),
  stroke: 0.5pt + col.lighten(52%),
  radius: 4pt,
  inset:  (x: 5pt, y: 2.5pt),
  text(size: 7.5pt, fill: col, weight: "semibold", body),
)

#let section(label, title, right_link: none) = {
  v(0.45cm)
  text(size: 7pt, fill: CA, weight: "bold", upper(label))
  linebreak()
  grid(
    columns: (1fr, auto),
    align: (bottom, bottom),
    text(size: 13pt, weight: "bold", fill: CT, title),
    if right_link != none {
      link(right_link)[
        #box(
          fill: CA.lighten(88%),
          stroke: 0.5pt + CA,
          radius: 4pt,
          inset: (x: 6pt, y: 3pt),
          text(size: 7.5pt, fill: CA, weight: "bold", "🔗 포트폴리오"),
        )
      ]
    }
  )
  v(0.06cm)
  line(length: 100%, stroke: 0.7pt + CB)
  v(0.2cm)
}

#let card(body) = block(
  width: 100%,
  fill: CL,
  stroke: 0.6pt + CB,
  radius: 7pt,
  inset: 12pt,
  body,
)

#let sublabel(t) = {
  v(0.24cm)
  text(size: 6.8pt, fill: CM, weight: "bold", upper(t))
  v(0.04cm)
  line(length: 100%, stroke: 0.5pt + CB)
  v(0.08cm)
}

#let sar(key, body, col: CA) = {
  v(0.08cm)
  grid(
    columns: (36pt, 1fr),
    column-gutter: 7pt,
    align: (top, top),
    box(
      fill: col.lighten(88%),
      stroke: none,
      radius: 3pt,
      inset: (x: 4pt, y: 3pt),
      align(center, text(size: 7.5pt, fill: col, weight: "bold", key)),
    ),
    text(size: 8.3pt, fill: CM, body),
  )
}

#let achtitle(num, body) = {
  v(0.15cm)
  text(size: 9pt, weight: "semibold")[
    #text(fill: CA, num + "  ")#body
  ]
}

#let adr(code, title, body, col: CA) = block(
  width: 100%,
  fill: CL,
  stroke: 0.5pt + CB,
  radius: 5pt,
  inset: 9pt,
  {
    box(
      fill: col.lighten(88%),
      stroke: 0.5pt + col.lighten(52%),
      radius: 3pt,
      inset: (x: 5pt, y: 2.5pt),
      text(size: 7pt, fill: col, weight: "bold", code)
    )
    h(5pt)
    text(size: 8.5pt, weight: "semibold", title)
    v(0.08cm)
    text(size: 8pt, fill: CM, body)
  }
)

#let ts-item(title, problem, solution, result) = block(
  width: 100%,
  fill: CL,
  stroke: 0.6pt + CB,
  radius: 6pt,
  inset: 11pt,
  {
    text(size: 8.5pt, weight: "bold", fill: CT, title)
    v(0.12cm)
    grid(
      columns: (36pt, 1fr),
      column-gutter: 7pt,
      row-gutter: 7pt,
      align: (top, top),
      box(fill: rgb("#f85149").lighten(85%), stroke: none, radius: 3pt,
        inset: (x:4pt,y:3pt), align(center, text(size:7pt, fill:rgb("#f85149"), weight:"bold", "문제"))),
      text(size: 8pt, fill: CM, problem),
      box(fill: CA.lighten(88%), stroke: none, radius: 3pt,
        inset: (x:4pt,y:3pt), align(center, text(size:7pt, fill:CA, weight:"bold", "해결"))),
      text(size: 8pt, fill: CM, solution),
      box(fill: CG.lighten(88%), stroke: none, radius: 3pt,
        inset: (x:4pt,y:3pt), align(center, text(size:7pt, fill:CG, weight:"bold", "결과"))),
      text(size: 8pt, fill: CM, result),
    )
  }
)

#let overview-block(label, body, col: CA) = block(
  fill: col.lighten(92%),
  stroke: (left: 2pt + col, rest: 0.5pt + CB),
  radius: (right: 5pt),
  inset: (x: 9pt, y: 7pt),
  width: 100%,
  {
    text(size: 7pt, fill: col, weight: "bold", label)
    linebreak()
    text(size: 8.3pt, fill: CM, body)
  }
)


// ════════════════════════════════════════════════════════════════
//  HEADER
// ════════════════════════════════════════════════════════════════

#align(center)[
  #text(size: 24pt, weight: "black", fill: CT)[
    전총명 #text(fill: CM, weight: "regular", size: 20pt)[|] 백엔드 개발자
  ]
  #v(0.14cm)
  #text(size: 9.5pt, fill: CA, weight: "semibold")[
    운영 중인 Java 서비스를 개선해 온 백엔드 개발자
  ]
  #v(0.08cm)
  #text(size: 8pt, fill: CM)[
    Java 백엔드 · 운영 서비스 개선 · 레거시 구조 분석
  ]
  #v(0.12cm)
  #text(size: 8pt, fill: CM)[
    010-8362-0913
    #h(1.2em) zsc0248\@naver.com
    #h(1.2em) #link("https://github.com/Kade-Jeon")[github.com/Kade-Jeon]
    #h(1.2em) #link("https://kade-jeon.github.io/AIAssistant/")[kade-jeon.github.io/AIAssistant/]
  ]
]


// ════════════════════════════════════════════════════════════════
//  ABOUT ME
// ════════════════════════════════════════════════════════════════

#section("About Me", "운영 중인 Java 서비스를 더 안정적이고 관리 가능한 구조로 개선합니다")

#text(size: 8.5pt, fill: CM)[
  공공·클라우드 메일 서비스에서 기능 개발, 장애 원인 분석, 외부 API 연동, 검색 기능 개선, ELK/APM 모니터링 구축을 경험했습니다.
]

#v(0.15cm)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  column-gutter: 8pt,
  ..(
    ("레거시 해석", "기존 구조를 빠르게 파악하고, 왜 그렇게 작성됐는지부터 이해합니다."),
    ("구조 개선", "단순 수정에 그치지 않고, 유지보수성과 확장성을 높이는 방향으로 개선합니다."),
    ("운영 가시성", "흩어진 로그와 병목을 관측 가능한 형태로 바꾸고 실제 개선까지 연결합니다."),
    ("실무 개선", "운영 중 반복되는 문제를 유지보수성과 확장성 관점에서 개선합니다."),
  ).map(((t, d)) => card[
    #text(size: 8.5pt, weight: "bold", fill: CA, t)
    #v(0.06cm)
    #text(size: 7.5pt, fill: CM, d)
  ])
)

#v(0.15cm)

#text(size: 9pt, fill: rgb("#374151"))[
  저는 공공·클라우드 메일 서비스를 개발·운영하며 고객사 요구사항 개발, 장애 원인 분석, 검색 기능 개선, SMS/MMS 외부 API 연동, ELK/APM 기반 모니터링 구축을 경험한 #text(weight: "bold", fill: CT)[Java 백엔드 개발자]입니다.

  #v(0.25cm)
  단순히 기능을 추가하는 것보다 기존 구조를 먼저 이해하고, 운영 중 반복되는 문제를 유지보수성과 확장성 관점에서 개선하는 데 집중해 왔습니다.
]


// ════════════════════════════════════════════════════════════════
//  WORK EXPERIENCE
// ════════════════════════════════════════════════════════════════

#section("Work Experience", "경력 사항")

#card[
  #grid(
    columns: (1fr, auto),
    align: (bottom, bottom),
    text(size: 12pt, weight: "bold")[크리니티],
    text(size: 8pt, fill: CM)[2024.05 — 2026.01 · 약 1년 9개월],
  )
  #text(size: 8.5pt, fill: CA, weight: "semibold")[Backend Developer · Cloud · 클라우드개발1팀(4인)]

  #v(0.12cm)
  #text(size: 8.5pt, fill: CM)[
    운영 중인 메일 서비스의 고객사 요구사항 개발, 장애 원인 분석, 레거시 기능 개선, 외부 API 연동, 검색 기능 개선, ELK/APM 기반 모니터링 구축을 수행했습니다. 단순 기능 추가보다 기존 구조를 이해하고, 운영 중 발생하는 문제를 유지보수성과 확장성 관점에서 개선하는 데 집중했습니다.
  ]

  #sublabel("담당 업무")
  - Java/JSP/JavaScript 기반 메일 서비스 기능 개발 및 유지보수
  - 고객사별 요구사항 반영, 버그 수정, 예외 케이스 대응
  - 고객사 13개 CS 채널 대응 및 운영 이슈 원인 분석
  - 레거시 검색 구조 기반 결과 내 재검색 기능 설계 및 구현
  - 통신사 SMS/MMS 외부 API 연동 및 대량 발송 구조 개선
  - ELK, Fleet, Elastic APM 기반 로그·성능 모니터링 환경 구축 참여
  - Spring AI 기반 공공 메일 서비스 AI 기능 PoC 설계 및 구현

  #sublabel("주요 프로젝트 / 성과")

  #achtitle("01", "고객사 SMS/MMS 외부 API 연동 개발")
  #sar("상황", "고객사에서 기존 SMS 기능을 MMS까지 확장해달라는 요구가 있었지만, 기존 로직은 shell curl 기반 API 호출 구조라 확장성과 예외 처리가 어려웠습니다.")
  #sar("행동", "통신사 최신 API 문서를 기준으로 RestTemplate 기반 연동 구조로 재구현하고, 공통 발송 로직과 SMS/MMS 타입별 처리 로직을 분리했습니다. 엑셀 대량 발송은 수신자 제한을 고려해 청크 단위로 나누고 CompletableFuture로 병렬 발송했습니다.", col: CP)
  #sar("결과", "한국농수산식품유통공사 운영에 적용되었고, 기존 SMS 단독 발송에서 MMS 이미지 발송과 엑셀 기반 대량 발송까지 지원 범위를 확장했습니다.", col: CG)

  #achtitle("02", "KISTI 프라이빗 클라우드 ELK 모니터링 시스템 구축")
  #sar("상황", "Scouter로는 일부 메트릭만 확인 가능했고, 로그 확인을 위해 VM root 접속이 필요해 장애 원인 파악이 느리고 보안·운영 리스크가 있었습니다.")
  #sar("행동", "Docker 기반 ELK Stack을 구성하고 Fleet·Elastic Agent로 중앙 수집, Kibana 권한 분리, Elastic APM으로 Java 메일 서비스 성능·트랜잭션 모니터링을 구축했습니다.", col: CP)
  #sar("결과", "KISTI 프라이빗 클라우드에 도입(2025.02~). 중앙 집중 조회로 장애·CS 대응 시간을 기존 대비 약 30% 수준으로 단축했고, APM 슬로우쿼리 분석으로 수신확인 기능의 불필요한 SQL 조건을 제거해 성능을 개선했습니다.", col: CG)

  #achtitle("03", "레거시 검색 구조 기반 결과 내 재검색 기능 구현")
  #sar("상황", "기존 검색은 1회성 조회만 가능해, 메일이 많이 누적된 고객사 환경에서 원하는 메일을 찾기 위해 검색어를 반복 입력해야 하는 불편이 있었습니다.")
  #sar("행동", "검색 엔진 자체 수정 대신, 초기 검색 결과와 재검색 결과의 mailUid 교집합만 최종 조회 대상으로 반영하는 방식으로 로직을 설계·구현했습니다.", col: CP)
  #sar("결과", "현재 검색 결과 기준으로 최대 5회까지 단계적으로 범위를 정제할 수 있게 되었고, 검색 엔진 구조를 크게 바꾸지 않고도 실사용 가치가 높은 기능을 확장했습니다.", col: CG)

  #achtitle("04", "레거시 공통 히스토리 처리 정상화 및 네비게이션 상태 개선")
  #sar("상황", "사내 공통 JavaScript 패키지의 히스토리 처리 때문에 뒤로가기 시 직전 화면으로 복귀하지 못하고, 메일함 하이라이트가 실제 화면과 어긋나는 문제가 있었습니다.")
  #sar("행동", "공통 히스토리 처리 로직을 분석한 뒤, 메일 상세·목록·메일함 이동 시점마다 유지되어야 할 화면 상태와 하이라이트 기준을 재정의하고 로직을 수정했습니다.", col: CP)
  #sar("결과", "뒤로가기 흐름이 사용자 기대에 맞게 일관되게 동작하도록 개선했고, 뒤로가기 관련 문의가 0건으로 줄었습니다.", col: CG)

  #achtitle("05", "Spring AI 기반 공공 메일 서비스 AI 기능 PoC")
  #sar("상황", "기존 AI 호출은 RestTemplate 기반이며 프롬프트·메시지가 하나의 문자열로 합쳐져 전송되어 응답 품질이 낮았고, RAG·에이전트 구조로 확장하기 어려웠습니다.")
  #sar("행동", "Spring AI ChatClient 구조로 역할을 분리하고, 메일 번역·외국어 메일 작성 기능을 구현했습니다. 이후 RAG·에이전트·Langfuse 확장을 고려한 아키텍처를 설계했습니다.", col: CP)
  #sar("결과", "NIA 대상 번역·메일 작성 AI 기능 베타 운영에 도입(2026.01~). G-cloud 공공 클라우드 메일의 최초 AI 기능으로 채택되었고, 이후 RAG 확장 요청에도 재설계 없이 대응 가능한 상태입니다.", col: CG)

  #sublabel("사용 기술")
  #for t in ("Java", "Spring Framework", "Spring Boot 3.x", "MySQL", "Kafka", "Redis", "JSP", "JavaScript", "Elasticsearch", "ELK Stack", "Elastic APM", "Docker", "Linux", "Jenkins", "KT Cloud", "NCP", "Spring AI", "Langfuse") {
    tag(t)
    h(3pt)
  }
]


// ════════════════════════════════════════════════════════════════
//  TECH STACK (실무)
// ════════════════════════════════════════════════════════════════

#section("Tech Stack", "기술 스택 — 실무 경험")

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.4cm,
  row-gutter: 0.3cm,

  card[
    #text(size: 9pt, weight: "bold")[Backend]
    #v(0.08cm)
    #for t in ("Java", "Spring Framework", "Spring Boot 3.x", "JSP", "JavaScript") { tag(t, col: CA); h(3pt) }
  ],
  card[
    #text(size: 9pt, weight: "bold")[DB · 메시징]
    #v(0.08cm)
    #for t in ("MySQL", "Kafka", "Redis", "Elasticsearch") { tag(t, col: CA); h(3pt) }
  ],
  card[
    #text(size: 9pt, weight: "bold")[모니터링 · 로그]
    #v(0.08cm)
    #for t in ("ELK Stack", "Elastic APM", "Fleet · Agent") { tag(t, col: CG); h(3pt) }
  ],
  card[
    #text(size: 9pt, weight: "bold")[클라우드 · 인프라]
    #v(0.08cm)
    #for t in ("KT Cloud", "NCP", "Docker", "Jenkins", "Git", "Linux") { tag(t, col: CG); h(3pt) }
  ],
  card[
    #text(size: 9pt, weight: "bold")[AI (실무 PoC)]
    #v(0.08cm)
    #for t in ("Spring AI", "RAG", "Langfuse") { tag(t, col: CY); h(3pt) }
  ],
)


// ════════════════════════════════════════════════════════════════
//  PROJECTS — AI Assistant
// ════════════════════════════════════════════════════════════════

#section("Projects", "프로젝트", right_link: "https://kade-jeon.github.io/AIAssistant/")

#text(size: 8.5pt, fill: CM)[개인 프로젝트 — AI 어시스턴트, 베리타(운영 종료), 글램독(Map·CRM/PMS·Bot)]

#v(0.15cm)
#text(size: 8pt, fill: CA, weight: "bold")[프로젝트 1 · AI 어시스턴트]

#card[
  #text(size: 11.5pt, weight: "bold")[AI Assistant — Backend]
  #v(0.05cm)
  #text(size: 8pt, fill: CM)[Spring Boot 3.5 #sym.dot.c Java 21 #sym.dot.c Spring AI 1.1.2 · 2026.01 — 2026.02]
  #v(0.1cm)
  #text(size: 8.3pt, fill: CM)[
    Java/Spring 기반으로 운영 가능한 AI 어시스턴트 백엔드 구조를 검증한 프로젝트입니다.
  ]

  #v(0.12cm)
  #overview-block("프로젝트 목적", [단순 챗봇 데모가 아니라, #text(weight:"bold", fill:CT)[AI 기능을 기존 Java/Spring 백엔드 서비스 안에 넣었을 때 필요한 구조를 검증]하는 것이 목적입니다. RAG, SSE 스트리밍, 대화 메모리, 관측성, 프롬프트 관리까지 포함해 실제로 운영 가능한 AI 백엔드 구조를 목표로 설계했습니다.], col: CY)
  #v(0.08cm)
  #overview-block("왜 Spring AI인가", [Python 생태계(LangChain 등)가 더 성숙하다는 점은 알고 있었습니다. 하지만 이 프로젝트의 목적은 #text(weight:"bold", fill:CT)[모델 실험이 아니라 서비스 통합]이었습니다. 메모리 관리, 스트리밍, 관측성, 장애 대응을 #text(weight:"bold", fill:CT)[Java/Spring 백엔드 개발자 관점]에서 기존 서비스 구조 안에서 풀어보고 싶었습니다.])
  #v(0.08cm)
  #overview-block("검증 결과", [로컬 Ollama와 연동해 #text(weight:"bold", fill:CT)[RAG · SSE 스트리밍 · 대화 메모리 · Langfuse 추적이 end-to-end로 동작]함을 확인했습니다.], col: CG)

  #sublabel("핵심 설계 포인트")
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 8pt,
    row-gutter: 8pt,
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 10pt,
      {text(size: 8.5pt, weight: "bold", "SSE 실시간 스트리밍"); v(0.06cm); text(size: 8pt, fill: CM, "토큰 단위 스트리밍과 재시도 구조로 응답 안정성을 고려했습니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 10pt,
      {text(size: 8.5pt, weight: "bold", "Tool-based RAG"); v(0.06cm); text(size: 8pt, fill: CM, "프로젝트형 채팅방에서만 벡터 검색 툴이 동작하도록 분리했습니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 10pt,
      {text(size: 8.5pt, weight: "bold", "Idempotency 보장"); v(0.06cm); text(size: 8pt, fill: CM, "중복 요청·재시도 시 동일 응답이 중복 저장되지 않도록 상태 기반 처리를 설계했습니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 10pt,
      {text(size: 8.5pt, weight: "bold", "LLM 완전 추적"); v(0.06cm); text(size: 8pt, fill: CM, "Langfuse·OpenTelemetry로 프롬프트·응답·지연을 추적합니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 10pt,
      {text(size: 8.5pt, weight: "bold", "이중 캐시 메모리"); v(0.06cm); text(size: 8pt, fill: CM, "Redis와 PostgreSQL에 대화 이력을 이중화했습니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 10pt,
      {text(size: 8.5pt, weight: "bold", "동적 프롬프트 관리"); v(0.06cm); text(size: 8pt, fill: CM, "Langfuse API에서 런타임 조회·캐시로 배포 없이 실험 가능합니다.")}),
  )

  #sublabel("기술 스택")
  #for t in ("Spring Boot 3.5", "Java 21", "Spring AI 1.1.2", "Ollama", "pgvector", "Redis", "PostgreSQL", "OpenTelemetry", "Langfuse", "Docker") {
    tag(t, col: CA); h(3pt)
  }

  #sublabel("핵심 아키텍처 결정 (ADR)")
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 8pt,
    adr("ADR-001", "Tool-based RAG를 선택한 이유",
      "매 요청마다 벡터 검색을 수행하면 지연·비용이 증가합니다. Spring AI \@Tool로 LLM이 검색 필요 여부를 판단하도록 설계했습니다.", col: CA),
    adr("ADR-002", "Idempotency — Strategy 패턴",
      "SSE 환경에서 X-Idempotency-Key 상태별 처리 로직을 Handler 구현체로 분리해 SRP·OCP를 확보했습니다.", col: CP),
  )

  #sublabel("시스템 아키텍처")
  #block(
    width: 100%,
    stroke: 0.5pt + CB,
    radius: 6pt,
    inset: 8pt,
    fill: rgb("#161b22"),
    image("./images/arch-typst.png", width: 100%)
  )

  #sublabel("트러블슈팅")
  #ts-item(
    "ChatMemoryRepository 커스텀 — 안정적 ID로 첨부파일 FK 연관관계 구현",
    [Spring AI 기본 JdbcChatMemoryRepository는 메시지 저장 시 대화 전체를 삭제 후 재삽입하여 CHAT_MESSAGE ID가 매 요청마다 재생성됩니다. CHAT_ATTACHMENT와 FK 연관이 불가능했습니다.],
    [ChatMemoryRepository를 직접 구현해 saveAll()을 append-only로 재정의하고, UUID로 ID를 1회만 할당했습니다.],
    [CHAT_MESSAGE ID 안정화로 FK·JPA \@OneToMany 매핑이 정상 동작합니다.],
  )
]

#v(0.25cm)
#card[
  #text(size: 11pt, weight: "bold")[AI Assistant — Frontend]
  #v(0.05cm)
  #text(size: 8pt, fill: CM)[Vue 3.5 #sym.dot.c TypeScript 5.9 #sym.dot.c Vite 7 #sym.dot.c Tailwind CSS 4]
  #v(0.08cm)
  #text(size: 8.3pt, fill: CM)[
    백엔드 API와 연동하는 Vue 3 프론트엔드. POST 기반 SSE는 Fetch API + ReadableStream으로 수신하고, Composables 패턴으로 상태를 관리했습니다.
  ]
  #sublabel("기술 스택")
  #for t in ("Vue 3.5", "TypeScript 5.9", "Vite 7", "Tailwind CSS 4", "Shadcn-vue", "SSE (ReadableStream)", "markdown-it") {
    tag(t, col: CP); h(3pt)
  }
]


// ════════════════════════════════════════════════════════════════
//  PROJECTS — Berita
// ════════════════════════════════════════════════════════════════

#v(0.2cm)
#text(size: 8pt, fill: CA, weight: "bold")[프로젝트 2 · 베리타 (Berita)]

#card[
  #grid(
    columns: (1fr, auto),
    align: (bottom, bottom),
    [#text(size: 11.5pt, weight: "bold")[토스 미니앱 서비스 — Berita]],
    [#text(size: 7.5pt, fill: CM, weight: "bold")[운영 종료]],
  )
  #v(0.05cm)
  #text(size: 8pt, fill: CM)[React · TypeScript · Supabase · AppsInToss · Granite · n8n · 2026.04 — 운영 종료]
  #v(0.08cm)
  #text(size: 8.3pt, fill: CM)[
    Gmail과 n8n으로 뉴스 후보를 모으고 운영자가 검수한 뒤 토스 미니앱으로 발행했던 뉴스 큐레이션 프로젝트입니다. 운영은 종료했습니다.
  ]

  #v(0.1cm)
  #overview-block("프로젝트 목적", [
    토스 미니앱으로 발행했던 뉴스 큐레이션 서비스입니다.
    #strong[n8n]으로 Gmail 기반 뉴스 후보를 자동 수집하고, Supabase에 섹션 단위로 저장한 뒤, 운영자가 검토·선정·보강하여 뉴스레터로 발행하는 semi-automated 운영 흐름을 구축했습니다.
  ], col: CY)
  #v(0.08cm)
  #overview-block("운영 아키텍처", [
    #strong[미니앱(newsletter)]은 Vite 빌드 후 토스 콘솔에 `ait` 패키지를 업로드해 배포했습니다.
    #strong[관리자(newsletter-admin)]에서 섹션·뉴스레터를 검수·선정·보강·발행했습니다.
    n8n 워크플로우가 Gmail 특정 메일함에서 뉴스 후보를 수집하고, 관리자 섹션 API(`x-n8n-secret`)를 통해 Supabase(PostgreSQL)에 섹션 단위로 적재했습니다.
  ])
  #v(0.08cm)
  #overview-block("운영 현황", [
    n8n 자동 수집 → DB 섹션 저장 → 운영자 검수·수정·보강 → 뉴스레터 발행까지 end-to-end 파이프라인을 구축·운영했습니다. 현재는 운영 종료 상태입니다.
    콘텐츠 보강은 AI가 아닌 운영자가 newsletter-admin에서 직접 수행했습니다.
  ], col: CG)

  #sublabel("핵심 설계 포인트")
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 8pt,
    row-gutter: 8pt,
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 9pt,
      {text(size: 8.5pt, weight: "bold", "n8n 토픽 자동 수집"); v(0.05cm); text(size: 8pt, fill: CM, "Gmail 특정 메일함에서 뉴스레터 토픽 후보를 주기적으로 수집했습니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 9pt,
      {text(size: 8.5pt, weight: "bold", "섹션 단위 DB 저장"); v(0.05cm); text(size: 8pt, fill: CM, "Supabase에 텍스트·미디어 블록 단위 섹션으로 저장 후 조합 발행했습니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 9pt,
      {text(size: 8.5pt, weight: "bold", "운영자 검수·보강"); v(0.05cm); text(size: 8pt, fill: CM, "자동 수집과 사람 검수를 분리해 콘텐츠 품질을 관리했습니다.")}),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 9pt,
      {text(size: 8.5pt, weight: "bold", "토스 미니앱 배포"); v(0.05cm); text(size: 8pt, fill: CM, "AppsInToss(Granite) · TDS Mobile WebView, `ait build` 산출물을 토스 콘솔에 업로드해 실서비스로 배포·운영했습니다. (현재 운영 종료)")}),
  )

  #sublabel("운영 아키텍처")
  #block(
    width: 100%,
    stroke: 0.5pt + CB,
    radius: 6pt,
    inset: 8pt,
    fill: white,
    image("./images/berita-arch-typst.png", width: 100%)
  )

  #sublabel("기술 스택")
  #text(size: 8pt, fill: CM, weight: "semibold")[Mini-app · Frontend]
  #h(4pt)
  #for t in ("React 19", "TypeScript", "AppsInToss · Granite", "TDS Mobile", "Vite") { tag(t, col: CP); h(3pt) }
  #v(0.1cm)
  #text(size: 8pt, fill: CM, weight: "semibold")[Backend · Data · Automation]
  #h(4pt)
  #for t in ("Supabase", "PostgreSQL", "Edge Functions", "n8n", "newsletter-admin", "Gmail 연동") { tag(t, col: CA); h(3pt) }
]




// ════════════════════════════════════════════════════════════════
//  PROJECTS — Glamdog (three products)
// ════════════════════════════════════════════════════════════════

#v(0.2cm)
#text(size: 8pt, fill: CA, weight: "bold")[프로젝트 3 · 글램독 (Glamdog)]

#card[
  #text(size: 11.5pt, weight: "bold")[글램독 — 고객 경험 · 운영 기반]
  #v(0.05cm)
  #text(size: 8.3pt, fill: CM)[
    고객 문의, 예약 운영, 현장 안내라는 서로 다른 문제를 세 개의 독립된 제품으로 해결하고 있습니다.
    Map은 양양점 현장에서 운영 중이며, 고객 안내 Bot은 베타 준비, CRM/PMS는 레거시 전환 개발 단계입니다.
  ]

  #v(0.12cm)
  #sublabel("제품 현황")
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 8pt,
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 9pt, {
      text(size: 8pt, fill: CA, weight: "bold", "01 · 현장 안내"); v(0.05cm)
      text(size: 8.5pt, weight: "bold", "Glamdog Map"); v(0.05cm)
      text(size: 8pt, fill: CM, "시설 위치와 이용 안내를 현장 디스플레이에 통합해 투숙객의 다음 행동을 안내합니다."); v(0.08cm)
      text(size: 7.5pt, fill: CG, weight: "bold", "양양점 현장 운영 중")
    }),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 9pt, {
      text(size: 8pt, fill: CA, weight: "bold", "02 · 운영 코어"); v(0.05cm)
      text(size: 8.5pt, weight: "bold", "Glamdog CRM/PMS"); v(0.05cm)
      text(size: 8pt, fill: CM, "예약과 객실을 중심으로 체크인, 청소, 정산, 스케줄과 지점별 협업 데이터를 연결합니다."); v(0.08cm)
      text(size: 7.5pt, fill: CY, weight: "bold", "레거시 전환 개발 중")
    }),
    block(fill: CL, stroke: 0.5pt + CB, radius: 5pt, inset: 9pt, {
      text(size: 8pt, fill: CA, weight: "bold", "03 · 고객 접점"); v(0.05cm)
      text(size: 8.5pt, weight: "bold", "Accommodation Bot"); v(0.05cm)
      text(size: 8pt, fill: CM, "지점별 정책과 운영 정보를 근거로 고객 문의에 답하고, 필요한 경우 현장 상담으로 연결합니다."); v(0.08cm)
      text(size: 7.5pt, fill: CY, weight: "bold", "양양점 베타 준비")
    }),
  )
]

// ════════════════════════════════════════════════════════════════
//  EDUCATION & ETC (이력서 요약)
// ════════════════════════════════════════════════════════════════

#section("Education", "학력 · 교육")

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.4cm,
  card[
    #text(size: 9pt, weight: "bold")[한경대학교 · 스포츠과학과]
    #v(0.05cm)
    #text(size: 8pt, fill: CM)[2011.03 — 2018.08 졸업 · 학점 4.08/4.5]
  ],
  card[
    #text(size: 9pt, weight: "bold")[엔코아 · Java 백엔드 개발자 과정]
    #v(0.05cm)
    #text(size: 8pt, fill: CM)[2023.06 — 2023.12 · Final Project: Job-a 팀장]
  ],
)

#v(0.15cm)
#text(size: 8pt, fill: CM)[
  자격증: 정보처리기사(2024.06) · SQL 개발자(2023.12) #h(1em) 어학: TOEIC 835점(2025.09)
]


// ════════════════════════════════════════════════════════════════
//  CONTACT
// ════════════════════════════════════════════════════════════════

#section("Contact", "함께 일해요")

#text(size: 8.5pt, fill: CM)[새로운 기회와 도전을 환영합니다. 언제든지 연락 주세요.]

#v(0.2cm)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.45cm,
  card[
    #text(size: 9pt, weight: "bold")[📧 Email]
    #v(0.06cm)
    #text(size: 8.5pt, fill: CA)[zsc0248\@naver.com]
  ],
  card[
    #text(size: 9pt, weight: "bold")[🐙 GitHub]
    #v(0.06cm)
    #link("https://github.com/Kade-Jeon")[
      #text(size: 8.5pt, fill: CA)[github.com/Kade-Jeon]
    ]
  ],
  card[
    #text(size: 9pt, weight: "bold")[💼 Wanted]
    #v(0.06cm)
    #link("https://social.wanted.co.kr/community/profile/W3xZKZKhwie8uLweYuCGLP")[
      #text(size: 8.5pt, fill: CA)[wanted.co.kr/profile]
    ]
  ],
)

#v(0.4cm)
#align(center)[
  #text(size: 7.5pt, fill: CM)[© 2026 Kade Jeon · Portfolio]
]
