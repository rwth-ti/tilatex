% Copyright (c) 2014 Institute for Theoretical Information Technology,
%                    RWTH Aachen University
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiexercise}[2014/11/04 v0.1]

\newcommand*{\setfirstproblem}{\setproblemnumber}

\def\tiexercise@insertheader{\insertexerciseheader}
\def\tiexercise@inserttext{\insertproblem}
\def\tiexercise@insertfile{\insertproblemfile}
\DeclareOption{additionalexercise}{
    \def\tiexercise@insertheader{\insertadditionalexerciseheader}
}
\DeclareOption{additionalexercisesolution}{
    \def\tiexercise@insertheader{\insertadditionalexercisesolutionheader}
    \def\tiexercise@inserttext{\insertsolution}
    \def\tiexercise@insertfile{\insertsolutionfile}

}
\DeclareOption{solution}{
    \def\tiexercise@insertheader{\insertsolutionheader}
    \def\tiexercise@inserttext{\insertsolution}
    \def\tiexercise@insertfile{\insertsolutionfile}
    \renewcommand*{\setfirstproblem}{\setsolutionnumber}
}

\def\tiexercise@language{ngerman}
\DeclareOption{english}{
    \expandafter\def\expandafter\tiexercise@language\expandafter{
        \CurrentOption
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

\AtBeginDocument{
    \expandafter\selectlanguage\expandafter{\tiexercise@language}
    \tiexercise@insertheader
}

\newcommand{\inserttext}{\tiexercise@inserttext}
\newcommand{\insertfile}{\tiexercise@insertfile}

\endinput

