% Copyright (c) 2014 Institute for Theoretical Information Technology,
%                    RWTH Aachen University
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiarticle}[2014/12/09 v0.1]

\ProcessOptions\relax

% Load the base class.
\LoadClass[12pt,a4paper]{article}

\usepackage[colorlinks=true]{hyperref}

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

\newcommand{\tiarticle@inserttiheader}{
  \begin{minipage}{\columnwidth}
    \begin{minipage}[b]{0.45\columnwidth}
      \textbf{\textsf{\tiarticle@documenttitle}}
    \end{minipage}
    \hfill%
    \includegraphics[width=0.5\columnwidth]{tilogo_ci}%
  \end{minipage}
  \vspace{2.5mm}%
  \hrule%
  \vspace{1mm}%
  \textbf{\footnotesize\tiarticle@authors}%
  \tiinternal@contentvpadding%
}

\AtBeginDocument{\tiarticle@inserttiheader}

\endinput

