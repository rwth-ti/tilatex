% Copyright (c) 2015 Institute for Theoretical Information Technology,
%                    RWTH Aachen University
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tiexam}[2015/03/10 v0.1]

\def\tiexam@language{ngerman}
\newif\iftiexam@english
\tiexam@englishfalse
\DeclareOption{english}{
  \tiexam@englishtrue
  \expandafter\def\expandafter\tiexam@language\expandafter{\CurrentOption}
  \PassOptionsToPackage{\CurrentOption}{tiproblem}
}

\newif\iftiexam@solution
\tiexam@solutionfalse
\DeclareOption{solution}{
  \tiexam@solutiontrue
}

\newif\iftiexam@handout
\tiexam@handoutfalse
\DeclareOption{handout}{
  \tiexam@handouttrue
}

\newif\iftiexam@showpoints
\tiexam@showpointsfalse
\DeclareOption{showpoints}{
  \tiexam@showpointstrue
}

\DeclareOption*{
  \ClassWarning{tiexam}{Unknown option '\CurrentOption'}
}

\ProcessOptions\relax

% Load the base class.
\LoadClass{tiarticle}

% Load other dependencies.
\usepackage{tiproblem}

% Overwrite datetime's am/pm formats.
\renewcommand{\amname}{a.m.}
\renewcommand{\pmname}{p.m.}

% Language agnostic defaults
\def\tiexam@examday{1}
\def\tiexam@exammonth{1}
\def\tiexam@examyear{1970}
\def\tiexam@examhour{0}
\def\tiexam@examminute{0}
\def\tiexam@passmark{25}
\def\tiexam@emptypagecount{3}
\def\tiexam@auxiliarypagecount{0}

% Set language-specific options.
\iftiexam@english
  % Set date and time formats.
  \newdateformat{tiexam@examdateformat}{%
    \dayofweekname{\THEDAY}{\THEMONTH}{\THEYEAR},~%
    \ordinaldate{\THEDAY}~\monthname[\THEMONTH],~\THEYEAR%
  }
  \def\tiexam@setdateformat{\tiexam@examdateformat}
  \newtimeformat{tiexam@timeformat}{%
    \twodigit{\THEHOURXII}:\twodigit{\THEMINUTE}~\amorpmname%
  }
  \settimeformat{tiexam@timeformat}

  % Initialize default labels.
  \def\tiexam@examlabel{Written examination}
  \def\tiexam@pointslabel{points}
  \def\tiexam@lecture{Lecture}
  \def\tiexam@lecturer{Lecturer}
  \def\tiexam@examresultsdescription{
    The results will be published on Tuesday, 26 August 2014, 16:00 on the
    homepage of the institute. \\[2mm] The corrected exams can be inspected on
    Friday, 01 January 1970, 0:00am at the Seminarraum 24 A 407 of the
    Institute for Theoretical Information Technology, Sommerfeldstr.\,24.
    \\[5mm]
  }
  \def\tiexam@studentinfoform{
    Name:~\hrulefill\hrulefill~~Matr.-No.:~\hrulefill \\[5mm]
    Field of study:~\hrulefill \\[5mm]
  }
  \def\tiexam@disclaimer{Please pay attention to the following}
  \def\tiexam@examnotes{
    \begin{description}
      \item[1) \phantom{al}] The exam consists of
        \textbf{\the\value{tiexam@ProblemCounter}~problems}. Please check the
        completeness of your copy. \textbf{Only} written solutions on these
        sheets will be considered. Removing the staples is \textbf{not}
        allowed.
      \item[2) \phantom{al}] The exam is passed with at least
        \textbf{\tiexam@passmark~points}.
      \item[3) \phantom{al}] You are free in choosing the order of working on
        the problems. Your solution shall clearly show the approach and
        intermediate arguments.
      \item[4) \phantom{al}] \textbf{Admitted materials:} The sheets handed out
        with the exam and a non-programmable calculator.
      \item[5) \phantom{al}] \tiexam@examresultsdescription
    \end{description}
  }
  \def\tiexam@examconfirmation{
    Acknowledged:\hfill
    \begin{minipage}[t]{10cm}
      \centering
      \hrulefill \\
      (Signature)
    \end{minipage}%
  }
\else
  % Set date and time formats.
  \newdateformat{tiexam@examdateformat}{%
    \dayofweekname{\THEDAY}{\THEMONTH}{\THEYEAR},~%
    \twodigit{\THEDAY}.~\monthname[\THEMONTH]~\THEYEAR%
  }
  \def\tiexam@setdateformat{\tiexam@examdateformat}
  \newtimeformat{tiexam@timeformat}{%
    \twodigit{\THEHOUR}:\twodigit{\THEMINUTE}~Uhr%
  }
  \settimeformat{tiexam@timeformat}

  % Initialize default labels.
  \def\tiexam@examlabel{Prüfungsklausur}
  \def\tiexam@pointslabel{Punkte}
  \def\tiexam@lecture{Vorlesung}
  \def\tiexam@lecturer{Dozent}
  \def\tiexam@examresultsdescription{
    Die Klausurergebnisse werden voraussichtlich am Donnerstag, den 01.01.1970,
    auf der Institutshomepage bekanntgegeben. \\[2mm] Die korrigierten
    Klausuren können am Freitag, den 01.01.1970, um 0 Uhr im Seminarraum 24 A
    407 des Lehrstuhls für Theoretische Informationstechnik, Sommerfeldstr. 24,
    eingesehen werden. \\[5mm]
  }
  \def\tiexam@studentinfoform{
    Name:~\hrulefill\hrulefill~~Matr.-Nr.:~\hrulefill \\[5mm]
    Fachrichtung:~\hrulefill \\[5mm]
  }
  \def\tiexam@disclaimer{Bitte beachten Sie Folgendes}
  \def\tiexam@examnotes{
    \begin{description}
      \item[1) \phantom{al}] Die Klausur besteht aus
        \textbf{\the\value{tiexam@ProblemCounter} Aufgaben}. Bitte prüfen Sie
        die Vollständigkeit Ihres Exemplars nach. \\[2mm] Bei der Korrektur
        werden \textbf{nur} die Lösungen auf diesen Blättern berücksichtigt.
        Das Entfernen der Heftklammern ist \textbf{nicht} erlaubt.
      \item[2) \phantom{al}] Die Klausur ist mit mindestens
        \textbf{\tiexam@passmark~Punkten} bestanden.
      \item[3) \phantom{al}] Die Reihenfolge der Bearbeitung der Aufgaben kann
        beliebig gewählt werden. Die Lösung der Aufgaben soll so erfolgen, dass
        der Lösungsweg deutlich erkennbar ist.
      \item[4) \phantom{al}] \textbf{Zugelassene Hilfsmittel:} Mit der Klausur
        ausgeteiltes Formelblatt, ein Lineal und ein gemäß der vorab
        veröffentlichten Positivliste zugelassener Taschenrechner.
      \item[5) \phantom{al}] \tiexam@examresultsdescription
    \end{description}
  }
  \def\tiexam@examconfirmation{
    Zur Kenntnis genommen:\hfill
    \begin{minipage}[t]{10cm}
      \centering
      \hrulefill \\
      (Unterschrift)
    \end{minipage}%
  }
\fi

% Define class commands.
\newcommand*{\setemptypagelayout}[2]{
  \def\tiexam@emptypagecount{#1}
  \def\tiexam@auxiliarypagecount{#2}
}

\newcommand*{\setexamdate}[5]{
  \def\tiexam@examday{#1}
  \def\tiexam@exammonth{#2}
  \def\tiexam@examyear{#3}
  \def\tiexam@examhour{#4}
  \def\tiexam@examminute{#5}
}

\newcommand*{\setpassmark}[1]{
  \def\tiexam@passmark{#1}
}

\newcommand*{\setexamresultsdescription}[1]{
  \def\tiexam@examresultsdescription{#1}
}

% Define internal counters.
\newcounter{tiexam@ProblemCounter}
\newcounter{tiexam@TotalPointsCounter}
\newcounter{tiexam@ProblemPageCounter}
\newcounter{tiexam@LoopCounter}

% Define internal class commands.
\newcommand*{\tiexam@insertheader}{%
  \pbox[t]{\textwidth}{%
    \vspace{0mm}
    \includegraphics[width=1.2cm]{ti_veclogo}%
    \textsf{\small{Lehrstuhl für}} \\
    \textsf{\large{Theoretische Informationstechnik}}
  }%
  \hfill
  \pbox[t]{\textwidth}{
    \vspace{0mm}
    \includegraphics[height=1.5cm]{RWTHAachenUniversity}
  }%
  \vspace{5mm}\hrule\vspace{5mm}
  \textbf{\tiproblem@lecturer}
}

% Definitions to generate the points table
\newtoks\tiexam@layouttokens\tiexam@layouttokens{}
\newtoks\tiexam@paddingtokens\tiexam@paddingtokens{}
\newtoks\tiexam@problemtokens\tiexam@problemtokens{}
\newtoks\tiexam@pointtokens\tiexam@pointtokens{}

\newcommand*{\tiexam@addgenerictokens}{%
  \tiexam@layouttokens\expandafter{\the\tiexam@layouttokens c|}%
  \tiexam@paddingtokens\expandafter{\the\tiexam@paddingtokens &}%
}
\newcommand*{\tiexam@addproblemtoken}[1]{%
  \edef\tiexam@tmp{\tiexam@problemtokens{\the\tiexam@problemtokens#1 &}}%
  \tiexam@tmp%
}
\newcommand*{\tiexam@addpointtoken}[1]{%
  \edef\tiexam@tmp{%
    \tiexam@pointtokens{\the\tiexam@pointtokens\noexpand\fbox{#1} &}%
  }%
  \tiexam@tmp%
}

\newcommand*{\tiexam@makecoverpage}{
  \setcounter{tiexam@LoopCounter}{0}
  \loop\ifnum\value{tiexam@LoopCounter} < \the\value{tiexam@ProblemCounter}
    \tiexam@addgenerictokens%
    \tiexam@addpointtoken{%
      \csname tiexam@problempoints\the\value{tiexam@LoopCounter} \endcsname%
    }%
    % This is ugly, but we want the problem count to start at 1, so we have to
    % increase the loop counter before appending the problem count token.
    \stepcounter{tiexam@LoopCounter}%
    \tiexam@addproblemtoken{\the\value{tiexam@LoopCounter}}%
  \repeat

  \tiexam@insertheader \\[8mm]
  \centerline{\small
    \tabcolsep5mm
    \begin{tabular}{|\the\tiexam@layouttokens|c|}
      \hline
      \the\tiexam@paddingtokens \\
      \the\tiexam@problemtokens $\sum$ \\
      \the\tiexam@paddingtokens \\
      \the\tiexam@pointtokens \fbox{\the\value{tiexam@TotalPointsCounter}} \\
      \the\tiexam@paddingtokens \\
      \hline
      \the\tiexam@paddingtokens \\
      \the\tiexam@paddingtokens \\
      \the\tiexam@paddingtokens \\
      \the\tiexam@paddingtokens \\
      \hline
    \end{tabular}
  } \\[8mm]
  \begin{center}
    {\large \textbf{\tiproblem@lecture}} \\[2mm]
    \textbf{\tiexam@examlabel} \\[2mm]
    \tiexam@setdateformat
    \formatdate{\tiexam@examday}{\tiexam@exammonth}{\tiexam@examyear},~%
    \formattime{\tiexam@examhour}{\tiexam@examminute}{00} \\
  \end{center}
  \vspace*{5mm}
  \tiexam@studentinfoform
  \textbf{\underline{\tiexam@disclaimer:}}
  {
    \footnotesize
    \tiexam@examnotes
    \tiexam@examconfirmation
  }
  \clearpage
}

\newcommand*{\defineexamproblem}[2]{
    \expandafter\def\csname
        tiexam@problemsource\the\value{tiexam@ProblemCounter} \endcsname{#1}
    \expandafter\def\csname
        tiexam@problempoints\the\value{tiexam@ProblemCounter} \endcsname{#2}
    \addtocounter{tiexam@TotalPointsCounter}{#2}
    \stepcounter{tiexam@ProblemCounter}
}

\newcommand{\tiexam@insertemptypages}[1]{
  \setcounter{tiexam@ProblemPageCounter}{0}
  \clearpage
  \iftiexam@solution
    \relax
  \else
  {
    \iftiexam@handout
      \relax
    \else
      \loop\ifnum\value{tiexam@ProblemPageCounter} < #1\relax
      \null\clearpage
      \stepcounter{tiexam@ProblemPageCounter}
      \repeat
    \fi
  }
  \fi
  \setcounter{tiexam@ProblemPageCounter}{0}
}

\newcommand*{\tiexam@printpoints}[1]{%
  (\csname tiexam@problempoints\the\value{#1} \endcsname~\tiexam@pointslabel)%
}
\newcommand*{\insertexamproblems}{
  \setcounter{tiexam@LoopCounter}{0}
  \loop\ifnum\value{tiexam@LoopCounter} < \the\value{tiexam@ProblemCounter}\relax
    \begin{problem}
      \iftiexam@handout
        \iftiexam@showpoints
          \tiexam@printpoints{tiexam@LoopCounter} \\
        \fi
        \relax
      \else
        \tiexam@printpoints{tiexam@LoopCounter} \\
      \fi
      \input{\csname tiexam@problemsource\the\value{tiexam@LoopCounter} \endcsname}
    \end{problem}
    \tiexam@insertemptypages{\tiexam@emptypagecount}
    % Force new problem to start on the left (even page).
    \iftiexam@solution
      \relax
    \else
    {
      \iftiexam@handout
        \relax
      \else
        \ifodd\value{page}\hbox{}\newpage\fi
      \fi
    }
    \fi
    \stepcounter{tiexam@LoopCounter}
  \repeat
}

\AtBeginDocument{
  % Select the proper language.
  \expandafter\selectlanguage\expandafter{\tiexam@language}

  % Add the cover page page if needed.
  \iftiexam@solution
    \relax
  \else
  {
    \iftiexam@handout
      \relax
    \else
      \tiexam@makecoverpage
    \fi
  }
  \fi
}

\AtEndDocument{
  \tiexam@insertemptypages{\tiexam@auxiliarypagecount}
}

\endinput

