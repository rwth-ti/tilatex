% Copyright (c) 2015 Institute for Theoretical Information Technology,
%                    RWTH Aachen University
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tithesisnotice}[2015/09/07 v0.1]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tiarticle}}

\ProcessOptions\relax

% Load the base class.
\LoadClass[11pt]{tiarticle}

\hypersetup{hidelinks}

\usepackage{enumitem}
\setlist[itemize]{topsep=0pt}
\usepackage{marvosym}

\newcommand*{\setthesistitle}[1]{
  \def\tithesisnotice@title{#1}
}
\setthesistitle{Thesis Title}

\newcommand*{\setthesissubtitle}[1]{
  \def\tithesisnotice@subtitle{#1}
}
\setthesissubtitle{}

\newcommand*{\heading}[1]{%
  \vspace*{3mm}\textbf{#1} \\
}

% From moderncviconsmarvosym.sty of moderncv:
\newcommand*{\tithesisnotice@marvosymbol}[1]{{%
  \fontfamily{mvs}\fontencoding{U}\fontseries{m}\fontshape{n}%
  \selectfont\char#1%
}}
\newcommand*{\contact}[3]{%
  #1\quad\tithesisnotice@marvosymbol{66}\;\href{mailto:#2}{#2}\;\;%
  \tithesisnotice@marvosymbol{84}\;+49 2421 80~#3%
}

\AtBeginDocument{
  \begin{minipage}{\columnwidth}
    \centering
    \Large\textbf{\tithesisnotice@title} \\
    \large\textbf{\tithesisnotice@subtitle}
  \end{minipage}
}

\endinput

