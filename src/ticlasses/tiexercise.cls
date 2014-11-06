\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiexercise}[2014/11/04 v0.1]

% TODO: Wrap \insertproblem and \insertsolution in another convenience macro
%       so we don't have to distinguish between the two in exercise documents.
\def\tiexercise@insertheader{\insertexerciseheader}
\DeclareOption{additionalexercise}{
    \def\tiexercise@insertheader{\insertadditionalexerciseheader}
}
\DeclareOption{solution}{
    \def\tiexercise@insertheader{\insertsolutionheader}
}

\DeclareOption{english}{
    \PassOptionsToPackage{\CurrentOption}{tiexercise}
}
\DeclareOption*{
    \ClassWarning{tiexercise}{Unknown option '\CurrentOption'}
}

\ProcessOptions\relax

% Load the base class.
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

\AtBeginDocument{\tiexercise@insertheader}

\endinput

