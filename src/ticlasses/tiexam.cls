% Copyright (c) 2015 Institute for Theoretical Information Technology,
%                    RWTH Aachen University
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiexam}[2015/03/10 v0.1]

% Initialize defaults.
\def\tiexam@emptypagecount{3}
\def\tiexam@auxiliarypagecount{0}
\def\tiexam@language{ngerman}
\def\tiexam@lecture{Vorlesung}
\def\tiexam@lecturer{Dozent}
\def\tiexam@examdate{Donnerstag, 1. Januar 1970}
\def\tiexam@examtime{0:00 Uhr}
\def\tiexam@examresultsdescription{
    Die Klausurergebnisse werden voraussichtlich am Donnerstag, den 01.01.1970,
    auf der Institutshomepage bekanntgegeben.\\[0.2cm] Die korrigierten
    Klausuren können am Freitag, den 01.01.1970, um 0 Uhr im Seminarraum 24 A
    407 des Lehrstuhls für Theoretische Informationstechnik, Sommerfeldstr. 24,
    eingesehen werden. \\[0.5cm]
}

\DeclareOption{english}{
    \expandafter\def\expandafter\tiexam@language\expandafter{
        \CurrentOption
    }
    \PassOptionsToPackage{\CurrentOption}{tiproblem}
}

\DeclareOption{solution}{
    \def\tiexam@solution{1}
}

\DeclareOption{handout}{
    \def\tiexam@handout{1}
}

\DeclareOption*{
    \ClassWarning{tiexam}{Unknown option '\CurrentOption'}
}

\ProcessOptions\relax

% Load the base class.
\LoadClass{tiarticle}

\usepackage{tiproblem}

% Define class commands.
\newcommand*{\setemptypagelayout}[2]{
    \def\tiexam@emptypagecount{#1}
    \def\tiexam@auxiliarypagecount{#2}
}

\newcommand{\setexamdate}[2]{
    \def\tiexam@examdate{#1}
    \def\tiexam@examtime{#2}
}

\newcommand*{\setexamresultsdescription}[1]{
    \def\tiexam@examresultsdescription{#1}
}

\newcommand*{\tiexam@makecoverpage}{
    % TODO: Add a \tiexam@insertheader macro.
    \parbox[t]{10cm}{%
        \includegraphics[width=1.2cm]{ti_veclogo}%
        \textsf{\small Lehrstuhl für} \\
        \textsf{\large Theoretische Informationstechnik}%
    }
    \hfill
    \parbox[t]{5.5cm}{%
        \includegraphics[width=5.5cm]{RWTHAachenUniversity}%
    }%
    \vspace{0.5cm} \hrule \vspace{0.5cm} \noindent

    \noindent\textbf{\tiproblem@lecturer} \\[8mm]
    \centerline{\small
        \tabcolsep0.5cm
        \begin{tabular}{|c|c|c|c||c|}
            \hline
            &&&& \\
            1 & 2 & 3 & 4 & $\sum$ \\
            &&&& \\
            % FIXME: Do this in a loop to support a variable number of
            %        problems. This is nontrivial though due to the use of
            %        ampersands and backslashes.
            \fbox{\csname tiexam@problempoints0 \endcsname} &
            \fbox{\csname tiexam@problempoints1 \endcsname} &
            \fbox{\csname tiexam@problempoints2 \endcsname} &
            \fbox{\csname tiexam@problempoints3 \endcsname} &
            \fbox{\the\value{tiexam@TotalPointsCounter}} \\
            &&&& \\
            \hline
            &&&& \\
            &&&& \\
            &&&& \\
            &&&& \\
            \hline
        \end{tabular}
    } \\[20pt]

    \begin{center}
        {\large \textbf{\tiproblem@lecture}} \\[0.2cm]
        \textbf{Prüfungsklausur} \\[0.2cm]
        \tiexam@examdate,~\tiexam@examtime \\
    \end{center}
    \vspace*{0.3cm}
    Name: \hrulefill\hrulefill \phantom{a} Matr.-Nr.: \hrulefill \\[5mm]
    Fachrichtung: \hrulefill  \\[5mm]
    \textbf{\underline{Bitte beachten Sie Folgendes:}}
    {
        \footnotesize
        \begin{description}
            \item[1) \phantom{al}] Die Klausur besteht aus \textbf{4 Aufgaben}.
                Bitte prüfen Sie die Vollständigkeit Ihres Exemplars nach.
                \\[0.2cm] Bei der Korrektur werden \textbf{nur} die Lösungen
                auf diesen Blättern berücksichtigt. Das Entfernen der
                Heftklammern ist \textbf{nicht} erlaubt.
            \item[2) \phantom{al}] Die Klausur ist mit mindestens \textbf{25
                Punkten} bestanden.
            \item[3) \phantom{al}] Die Reihenfolge der Bearbeitung der Aufgaben
                kann beliebig gewählt werden. Die Lösung der Aufgaben soll so
                erfolgen, dass der Lösungsweg deutlich erkennbar ist.
            \item[4) \phantom{al}] \textbf{Zugelassene Hilfsmittel:} Mit der
                Klausur ausgeteiltes Formelblatt, ein Lineal und ein gemäß
                der vorab veröffentlichten Positivliste zugelassener
                Taschenrechner.
            \item[5) \phantom{al}] \tiexam@examresultsdescription
        \end{description}
        % XXX: Oh my, such an elegant solution!
        Zur Kenntnis genommen: \phantom{hjkhjkhjkhjk}\hrulefill \\
        \phantom{lalalalalalallklkklkalalalalalalalalllllllllklkjlkjlkjlkjlkja}
        \hspace*{2.0cm}(Unterschrift)\phantom{lalalalalalalalalalalalalala}
    }
    \clearpage
}

\AtBeginDocument{
    % Select the proper language.
    \expandafter\selectlanguage\expandafter{\tiexam@language}

    \ifx\tiexam@solution\undefined
    {
        \ifx\tiexam@handout\undefined
        {
            \tiexam@makecoverpage
        }
        \else\relax\fi
    }
    \else\relax\fi
}

\AtEndDocument{
    % Insert blank pages at the end of the document if we're not compiling a
    % solution or handout document.
    % TODO: Add a better abstraction for this so we can re-use it when
    %       inserting the individiaul problems.
    \clearpage
    \ifx\tiexam@solution\undefined
    {
        \ifx\tiexam@handout\undefined
        {
            \loop\ifnum\value{tiexam@ProblemPageCounter} < \tiexam@auxiliarypagecount\relax
            \null\clearpage
            \stepcounter{tiexam@ProblemPageCounter}
            \repeat
        }
        \else\relax\fi
    }
    \else\relax\fi
}

\newcounter{tiexam@ProblemCounter}
\newcounter{tiexam@TotalPointsCounter}
\newcommand*{\defineexamproblem}[2]{
    \expandafter\def\csname
        tiexam@problemsource\the\value{tiexam@ProblemCounter} \endcsname{#1}
    \expandafter\def\csname
        tiexam@problempoints\the\value{tiexam@ProblemCounter} \endcsname{#2}
    \addtocounter{tiexam@TotalPointsCounter}{#2}
    \stepcounter{tiexam@ProblemCounter}
}

\newcounter{tiexam@LoopCounter}
\newcounter{tiexam@ProblemPageCounter}
\newcommand*{\insertexamproblems}{
    \loop\ifnum\value{tiexam@LoopCounter} < \value{tiexam@ProblemCounter}\relax
        \begin{problem}
            \ifx\tiexam@handout\undefined
                (\csname tiexam@problempoints\the\value{tiexam@LoopCounter} \endcsname~Punkte) \\
            \else
                \relax
            \fi
            \input{\csname tiexam@problemsource\the\value{tiexam@LoopCounter} \endcsname}
        \end{problem}
        \clearpage
        % Insert blank pages after the problem page if we're not compiling a
        % solution or handout document.
        \ifx\tiexam@solution\undefined
        {
            \ifx\tiexam@handout\undefined
            {
                \loop\ifnum\value{tiexam@ProblemPageCounter} < \tiexam@emptypagecount\relax
                \null\clearpage
                \stepcounter{tiexam@ProblemPageCounter}
                \repeat
            }
            \else\relax\fi
        }
        \else\relax\fi
        \setcounter{tiexam@ProblemPageCounter}{0}
        \stepcounter{tiexam@LoopCounter}
    \repeat
}

\endinput

