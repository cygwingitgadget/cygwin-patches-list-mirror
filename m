Return-Path: <cygwin-patches-return-4725-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3951 invoked by alias); 7 May 2004 03:27:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3941 invoked from network); 7 May 2004 03:27:13 -0000
Date: Fri, 07 May 2004 03:27:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040507032703.GA950@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00077.txt.bz2

On Thu, May 06, 2004 at 07:18:39PM -0500, Brian Ford wrote:
>Although not the complete rewrite you may have been hoping for, the
>attached patch does appear to fix the:
>
>Winmain: Cannot register window class, Win32 error 1410
>
>portion of this bug:
>
>http://www.cygwin.com/ml/cygwin/2004-05/msg00232.html

Thanks, but, I see that you're using busy loops.  I use those in places
where I have no choice but to do so or when the potential for a race is
unlikely.

I don't think that this is really a situation that qualifies for either.
It seems like a muto is a cleaner choice here.

cgf

>2004-05-06  Brian Ford  <ford@vss.fsi.com>
>
>	* window.cc (window_started): Change type to long and make NO_COPY.
>	(Winmain): Use InterlockedExchange instead of SetEvent.
>	(gethwnd): Fix initialization race using InterlockedExchange
>	based state table.
>
>-- 
>Brian Ford
>Senior Realtime Software Engineer
>VITAL - Visual Simulation Systems
>FlightSafety International
>the best safety device in any aircraft is a well-trained pilot...
>Index: window.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/window.cc,v
>retrieving revision 1.30
>diff -u -p -r1.30 window.cc
>--- window.cc	9 Feb 2004 04:04:24 -0000	1.30
>+++ window.cc	7 May 2004 00:02:31 -0000
>@@ -73,7 +73,7 @@ WndProc (HWND hwnd, UINT uMsg, WPARAM wP
>     }
> }
> 
>-static HANDLE window_started;
>+static NO_COPY long window_started;
> 
> static DWORD WINAPI
> Winmain (VOID *)
>@@ -104,17 +104,17 @@ Winmain (VOID *)
>   /* Create hidden window. */
>   ourhwnd = CreateWindow (classname, classname, WS_POPUP, CW_USEDEFAULT,
> 			  CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
>-			  (HWND) NULL, (HMENU) NULL, user_data->hmodule,
>-			  (LPVOID) NULL);
>-
>-  SetEvent (window_started);
>+			  NULL, NULL, user_data->hmodule, NULL);
> 
>   if (!ourhwnd)
>     {
>       system_printf ("Cannot create window");
>+      InterlockedExchange (&window_started, 0);
>       return FALSE;
>     }
> 
>+  InterlockedExchange (&window_started, 1);
>+
>   /* Start the message loop. */
> 
>   while (GetMessage (&msg, ourhwnd, 0, 0) == TRUE)
>@@ -126,17 +126,22 @@ Winmain (VOID *)
> HWND __stdcall
> gethwnd ()
> {
>-  if (ourhwnd != NULL)
>-    return ourhwnd;
>+  long ws = InterlockedExchange (&window_started, -1);
> 
>-  cygthread *h;
>+  if (ws == 1)
>+    InterlockedExchange (&window_started, 1);
>+  else
>+    {
>+      if (ws == 0)
>+	{
>+	  cygthread *h = new cygthread (Winmain, NULL, "win");
>+	  h->zap_h ();
>+	}
>+    
>+      while (window_started == -1)
>+	low_priority_sleep (0);
>+    }
> 
>-  window_started = CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
>-  h = new cygthread (Winmain, NULL, "win");
>-  h->SetThreadPriority (THREAD_PRIORITY_HIGHEST);
>-  WaitForSingleObject (window_started, INFINITE);
>-  CloseHandle (window_started);
>-  h->zap_h ();
>   return ourhwnd;
> }
> 
