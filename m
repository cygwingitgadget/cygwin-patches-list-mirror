Return-Path: <cygwin-patches-return-1975-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7914 invoked by alias); 11 Mar 2002 18:31:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7889 invoked from network); 11 Mar 2002 18:30:59 -0000
Message-ID: <3C8CF7AA.BE1157DE@yahoo.com>
Date: Mon, 11 Mar 2002 10:35:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
CC: cygwin-patches@cygwin.com
Subject: Re: (small) kill.cc patch
References: <20020311181627.8971.qmail@web20001.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00332.txt.bz2


Your ChangeLog entry is improper format.  Try again.

Earnie.

Joshua Daniel Franklin wrote:
> 
> Here is a patch that moves the functions in kill.cc to the top.
> That's all it does.
> 
> This is for consistency with the other utils.
> 
> 2001-03-11 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
> * kill.cc (usage) move to top of file
>           (getsig) ditto
>           (forcekill) ditto
> 
> __________________________________________________
> Do You Yahoo!?
> Try FREE Yahoo! Mail - the world's greatest free email!
> http://mail.yahoo.com/
> 
>   ------------------------------------------------------------------------
> --- kill.cc-orig        Sun Feb 24 13:28:27 2002
> +++ kill.cc     Mon Mar 11 12:07:40 2002
> @@ -17,9 +17,42 @@ details. */
>  #include <windows.h>
>  #include <sys/cygwin.h>
> 
> -static void usage (void);
> -static int __stdcall getsig (char *);
> -static void __stdcall forcekill (int, int, int);
> +static void
> +usage (void)
> +{
> +  fprintf (stderr, "Usage: kill [-sigN] pid1 [pid2 ...]\n");
> +  exit (1);
> +}
> +
> +static int
> +getsig (char *in_sig)
> +{
> +  char *sig;
> +  char buf[80];
> +
> +  if (strncmp (in_sig, "SIG", 3) == 0)
> +    sig = in_sig;
> +  else
> +    {
> +      sprintf (buf, "SIG%s", in_sig);
> +      sig = buf;
> +    }
> +  return (strtosigno (sig) ?: atoi (in_sig));
> +}
> +
> +static void __stdcall
> +forcekill (int pid, int sig, int wait)
> +{
> +  external_pinfo *p = (external_pinfo *) cygwin_internal (CW_GETPINFO_FULL, pid);
> +  if (!p)
> +    return;
> +  HANDLE h = OpenProcess (PROCESS_TERMINATE, FALSE, (DWORD) p->dwProcessId);
> +  if (!h)
> +    return;
> +  if (!wait || WaitForSingleObject (h, 200) != WAIT_OBJECT_0)
> +    TerminateProcess (h, sig << 8);
> +  CloseHandle (h);
> +}
> 
>  int
>  main (int argc, char **argv)
> @@ -82,41 +115,4 @@ sig0:
>        argv++;
>      }
>    return ret;
> -}
> -
> -static void
> -usage (void)
> -{
> -  fprintf (stderr, "Usage: kill [-sigN] pid1 [pid2 ...]\n");
> -  exit (1);
> -}
> -
> -static int
> -getsig (char *in_sig)
> -{
> -  char *sig;
> -  char buf[80];
> -
> -  if (strncmp (in_sig, "SIG", 3) == 0)
> -    sig = in_sig;
> -  else
> -    {
> -      sprintf (buf, "SIG%s", in_sig);
> -      sig = buf;
> -    }
> -  return (strtosigno (sig) ?: atoi (in_sig));
> -}
> -
> -static void __stdcall
> -forcekill (int pid, int sig, int wait)
> -{
> -  external_pinfo *p = (external_pinfo *) cygwin_internal (CW_GETPINFO_FULL, pid);
> -  if (!p)
> -    return;
> -  HANDLE h = OpenProcess (PROCESS_TERMINATE, FALSE, (DWORD) p->dwProcessId);
> -  if (!h)
> -    return;
> -  if (!wait || WaitForSingleObject (h, 200) != WAIT_OBJECT_0)
> -    TerminateProcess (h, sig << 8);
> -  CloseHandle (h);
>  }

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

