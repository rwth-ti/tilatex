\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiexercise}[2014/11/04 v0.1]

\DeclareOption*{
  \ClassWarning{tiexercise}{Unknown option '\CurrentOption'}
}

\ProcessOptions\relax

% Load base class
\LoadClass[12pt,a4paper]{article}

\usepackage{tiexercise}

% Page layout
\setlength{\textheight}{25.5truecm}
\setlength{\textwidth}{16.2truecm}
\hoffset=-1cm
\voffset=-2cm
\pagestyle{empty}
\parindent=0pt
\parskip=5pt

\endinput

