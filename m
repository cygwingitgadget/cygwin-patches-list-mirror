Return-Path: <cygwin-patches-return-1681-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21141 invoked by alias); 12 Jan 2002 19:10:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21127 invoked from network); 12 Jan 2002 19:10:11 -0000
Message-ID: <3C4089E1.248F3A9@yahoo.com>
Date: Sat, 12 Jan 2002 11:10:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Bradshaw <bradshaw@staff.crosswalk.com>
CC: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] mkpasswd.c - Central error reporting
References: <911C684A29ACD311921800508B7293BA037D29EB@cnmail>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00038.txt.bz2

Mark Bradshaw wrote:
> 
> My changelog is being evil.
> 
> 2002-01-12  Mark Bradshaw  <bradshaw@crosswalk.com>
> 
>         * mkpasswd.c (print_win_error): Add a new function, print_win_error,
>                 that will attempt to get a text message to go along with any
>                 error code that is passed to it.
>         (enum_users): Replace any lines that did error reporting with calls
>                 to the new function, print_win_error.
>         (enum_local_groups): Replace any lines that did error reporting with
>                 calls to the new function, print_win_error.
>         (main): Replace SOME lines that did error reporting with calls
>                 to the new function, print_win_error.
> 

That should read:

2002-01-12  Mark Bradshaw  <bradshaw@crosswalk.com>

        * mkpasswd.c (print_win_error): Add a new function.
        (enum_users): Use print_win_error.
        (enum_local_groups): Ditto.
        (main): Ditto.


Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

