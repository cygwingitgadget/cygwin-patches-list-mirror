Return-Path: <cygwin-patches-return-4288-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32023 invoked by alias); 11 Oct 2003 11:29:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32013 invoked from network); 11 Oct 2003 11:29:30 -0000
Date: Sat, 11 Oct 2003 11:29:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: winsup/w32api/include
Message-ID: <20031011112929.GV14344@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031010210215.00826510@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031010210215.00826510@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00007.txt.bz2

On Fri, Oct 10, 2003 at 09:02:15PM -0400, Pierre A. Humblet wrote:
> 
> For the SM_REMOTESESSION in winuser.h,
> see
> <http://vbvbvb.com/jp/gtips/1051/gGetSystemMetricsSmRemotesession.html>
> <http://tdg.lsi.us.es/pipermail/csharp-dist/2003-March/002832.html>
> 
> For SE_CREATE_GLOBAL_NAME in winnt.h, that name is an educated guess 
> from its value. 
> 
> I don't know if guards depending on the Windows version are needed.

The SM_REMOTESESSION should be available since NT4 SP4.  I don't
know how that should be guarded correctly.

The patch is fine with me.

Corinna

> 
> Pierre
> 
> 2003-10-11  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* include/winnt.h (SM_REMOTESESSION): Add define.
> 	* include/winuser.h (SE_CREATE_GLOBAL_NAME): Ditto.
> 
> Index: winnt.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/w32api/include/winnt.h,v
> retrieving revision 1.72
> diff -u -p -r1.72 winnt.h
> --- winnt.h     26 Sep 2003 08:19:30 -0000      1.72
> +++ winnt.h     10 Oct 2003 23:54:44 -0000
> @@ -470,6 +470,7 @@ typedef DWORD FLONG;
>  #define SE_SYSTEM_ENVIRONMENT_NAME     TEXT("SeSystemEnvironmentPrivilege")
>  #define SE_CHANGE_NOTIFY_NAME  TEXT("SeChangeNotifyPrivilege")
>  #define SE_REMOTE_SHUTDOWN_NAME        TEXT("SeRemoteShutdownPrivilege")
> +#define SE_CREATE_GLOBAL_NAME TEXT("SeCreateGlobalPrivilege")
>  #define SE_GROUP_MANDATORY 1
>  #define SE_GROUP_ENABLED_BY_DEFAULT 2
>  #define SE_GROUP_ENABLED 4
> Index: winuser.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/w32api/include/winuser.h,v
> retrieving revision 1.73
> diff -u -p -r1.73 winuser.h
> --- winuser.h   30 Sep 2003 07:51:25 -0000      1.73
> +++ winuser.h   10 Oct 2003 23:54:51 -0000
> @@ -918,6 +918,7 @@ extern "C" {
>  #else
>  #define SM_CMETRICS 83
>  #endif
> +#define SM_REMOTESESSION 0X1000
>  #define ARW_BOTTOMLEFT 0
>  #define ARW_BOTTOMRIGHT 1
>  #define ARW_HIDE 8

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
