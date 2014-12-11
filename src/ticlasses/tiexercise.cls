\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiexercise}[2014/11/04 v0.1]

\def\tiexercise@insertheader{\insertexerciseheader}
\def\tiexercise@inserttext{\insertproblem}
\DeclareOption{additionalexercise}{
    \def\tiexercise@insertheader{\insertadditionalexerciseheader}
}
\newcommand*{\setfirstproblem}{\setproblemnumber}
\DeclareOption{solution}{
    \def\tiexercise@insertheader{\insertsolutionheader}
    \def\tiexercise@inserttext{\insertsolution}
    \renewcommand*{\setfirstproblem}{\setsolutionnumber}
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
\LoadClass{tiarticle}

\usepackage{tiproblem}

\AtBeginDocument{%
    \expandafter\selectlanguage\expandafter{\tiexercise@language}%
    \tiexercise@insertheader%
}

\newcommand{\inserttext}{\tiexercise@inserttext}

\endinput

