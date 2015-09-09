% Copyright (c) 2014 Institute for Theoretical Information Technology,
%                    RWTH Aachen University
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiarticle}[2014/12/09 v0.1]

\def\tiarticle@language{ngerman}
\def\tiarticle@logo{rwth_ti_de_rgb}
\DeclareOption{english}{
  \expandafter\def\expandafter\tiarticle@language\expandafter{\CurrentOption}
  \def\tiarticle@logo{rwth_ti_en_rgb}
}

\DeclareOption*{
  \ClassWarning{tiexam}{Unknown option '\CurrentOption'}
}

\ProcessOptions\relax

% Load the base class.
\LoadClass[12pt,a4paper]{article}

\usepackage[colorlinks=true]{hyperref}

\usepackage{tiinternal}

% Page layout
\pagestyle{empty}
\usepackage[
  left=2.5cm,
  right=2.5cm,
  top=2cm,
  bottom=3cm
]{geometry}
\parindent=0pt
\parskip=5pt

\newcommand*{\setdocumenttitle}[1]{
  \def\tiarticle@documenttitle{#1}
}
\setdocumenttitle{}

\newcommand*{\setauthors}[1]{
  \def\tiarticle@authors{#1}
}
\setauthors{}

% The corporate identity logo has an 8 mm border around its bounding box. We
% (arbitrarily) scale the logo by 0.625 so it's approximately as large as it
% would be with width=0.5\columnwidth. This means we need to pad the document
% title and author list by 8 mm * 0.625 = 0.5 mm so the gaps match.
\def\tiarticle@padding{5mm}
\newcommand{\tiarticle@inserttiheader}{
  \begin{minipage}{\columnwidth}
    \begin{minipage}[b]{0.45\columnwidth}
      \textbf{\textsf{\tiarticle@documenttitle}}
      \vspace{\tiarticle@padding}
    \end{minipage}
    \hfill
    \includegraphics[scale=0.625]{\tiarticle@logo}
  \end{minipage}
  \hrule
  \vspace{\tiarticle@padding}
  \textbf{\footnotesize\tiarticle@authors}
  \tiinternal@contentvpadding \\
}

\AtBeginDocument{
  \expandafter\selectlanguage\expandafter{\tiarticle@language}
  \tiarticle@inserttiheader
}

\endinput

