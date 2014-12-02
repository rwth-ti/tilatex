\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiexercise}[2014/11/04 v0.1]

\def\tiexercise@insertheader{\insertexerciseheader}
\def\tiexercise@inserttext{\insertproblem}
\DeclareOption{additionalexercise}{
    \def\tiexercise@insertheader{\insertadditionalexerciseheader}
}
\DeclareOption{solution}{
    \def\tiexercise@insertheader{\insertsolutionheader}
    \def\tiexercise@inserttext{\insertsolution}
}

\def\tiexercise@language{ngerman}
\DeclareOption{english}{
    \expandafter\def\expandafter\tiexercise@language\expandafter{%
        \CurrentOption%
    }
    \PassOptionsToPackage{\CurrentOption}{tiproblem}
}
\DeclareOption*{
    \ClassWarning{tiexercise}{Unknown option '\CurrentOption'}
}

\ProcessOptions\relax

% Load the base class.
\LoadClass[12pt,a4paper]{article}

\usepackage{tiproblem}

% Page layout
\setlength{\textheight}{25.5truecm}
\setlength{\textwidth}{16.2truecm}
\hoffset=-1cm
\voffset=-2cm
\pagestyle{empty}
\parindent=0pt
\parskip=5pt

\AtBeginDocument{%
    \expandafter\selectlanguage\expandafter{\tiexercise@language}%
    \tiexercise@insertheader%
}

\newcommand{\inserttext}{\tiexercise@inserttext}

\endinput

