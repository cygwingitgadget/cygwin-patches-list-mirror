Return-Path: <cygwin-patches-return-1652-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22400 invoked by alias); 3 Jan 2002 10:11:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22385 invoked from network); 3 Jan 2002 10:11:46 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Thu, 03 Jan 2002 02:11:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKOEDJCIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <08f801c1943c$9ea47090$0200a8c0@lifelesswks>
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00009.txt.bz2

> I'd love a patch with the following:
>  * cistring.cc: Ran d2u.
>  * cistring.h: Ditto.
>  * desktop.h: Ditto.
>  * localdir.h: Ditto.
>  * net.h: Ditto.
>  * proppage.h: Ditto.
>  * propsheet.h: Ditto.
>  * root.h: Ditto.
>  * source.h: Ditto.
>  * splash.h: Ditto.
>  * threebar.cc: Ditto.
>  * threebar.h: Ditto.
>
> and all *your* changes as per the last patch you gave me, that doesn't
> back out any previous patches from Chris or me..
> Such a patch would save me a huge amount of time. I'm attaching a sample
> file so you can see my confusion... (it's the double >>>> 's that are
> worrying me.)
>

Ok, that's what I'm talking about.  Give me a few minutes to update the
changelog and make sure I actually did that already and I'll get that to you.

> As for your Makefile.in iniparse Change, I think that's wrong (at first
> glance) as Chris already patched that to allow both new and old bisons.

Yeah, I'm not 100% convinced it's right either, but I get a ".hh" out of "bison
(GNU Bison) 1.30", not a ".cc.h".  Maybe give me an extra minute or two on that
one, but what do you want if I find nothing?

--
Gary R. Van Sickle
Brewer.  Patriot.

> -----Original Message-----
> From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> Sent: Thursday, January 03, 2002 3:54 AM
> To: Gary R. Van Sickle
> Cc: cygwin-patches@cygwin.com
> Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf
> packages]
>
>
>
> ===
> ----- Original Message -----
> From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
> To: "Robert Collins" <robert.collins@itdomain.com.au>
> Cc: <cygwin-patches@cygwin.com>
> Sent: Thursday, January 03, 2002 8:46 PM
> Subject: RE: setup.exe remove scripts [Was: Re: experimental texmf
> packages]
>
>
> > > -----Original Message-----
> > > From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> > > Sent: Thursday, January 03, 2002 3:27 AM
> > > To: Jan Nieuwenhuizen; Gary R. Van Sickle
> > > Cc: cygwin-patches@cygwin.com
> > > Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf
> > > packages]
> > >
> > >
> > > Right.  I completley naffed my sandbox with Gary's work in it :[.
> > >
> > > Gary... can I please have that missing bit of the changelog?
> > >
> > > Jan, I'll get your patch in straight after I commit Gary's.
> > >
> >
> > Attached, but see my last comment in my previous post - it appears to
> be broken
> > as far as downloading setup.ini now.  Don't know if it's you or me or
> what yet.
>
> You :]. Well probably :]. One step at a time. As I wrote, I totalled
> *trashed* my sandbox.
>
> > Will also send a new diff against a current cvs update as soon the
> load average
> > goes down and I can get in, if that will be of any help.  Otherwise
> feel free to
> > ignore it, there's only one non-cvs-diff-related change, in
> Makefile.in (and
> > this line is *not* in the attached changelog on the assumption you
> won't need
> > the patch):
>
> Rob
>
> === net.cc (stuffed) ===
> /*
>  * Copyright (c) 2000, Red Hat, Inc.
>  *
>  *     This program is free software; you can redistribute it and/or
> modify
>  *     it under the terms of the GNU General Public License as published
> by
>  *     the Free Software Foundation; either version 2 of the License, or
>  *     (at your option) any later version.
>  *
>  *     A copy of the GNU General Public License can be found at
>  *     http://www.gnu.org/
>  *
>  * Written by DJ Delorie <dj@cygnus.com>
>  *
>  */
>
> /* The purpose of this file is to get the network configuration
>    information from the user. */
>
> #if 0
> static const char *cvsid =
>   "\n%%% $Id: net.cc,v 2.8 2001/12/23 12:13:29 rbcollins Exp $\n";
> #endif
>
> #include "win32.h"
> #include <stdio.h>
> #include <stdlib.h>
> #include "dialog.h"
> #include "resource.h"
> #include "state.h"
> #include "msg.h"
> #include "log.h"
>
> <<<<<<< net.cc
> <<<<<<< net.cc
> #include "net.h"
> #include "propsheet.h"
> #include "threebar.h"
> extern ThreeBarProgressPage Progress;
>
> =======
> >>>>>>> 2.7
> =======
> #include "net.h"
>
> #include "threebar.h"
> extern ThreeBarProgressPage Progress;
>
> >>>>>>> 2.8
> static int rb[] = { IDC_NET_IE5, IDC_NET_DIRECT, IDC_NET_PROXY, 0 };
>
> void
> NetPage::CheckIfEnableNext ()
> {
>   int e = 0, p = 0, pu = 0;
>   DWORD ButtonFlags = PSWIZB_BACK;
>
>   if (net_method == IDC_NET_IE5)
>     pu = 1;
>   if (net_method == IDC_NET_IE5 || net_method == IDC_NET_DIRECT)
>     e = 1;
>   else if (net_method == IDC_NET_PROXY)
>     {
>       p = pu = 1;
>       if (net_proxy_host && net_proxy_port)
>  e = 1;
>     }
>  if (e)
>  {
>   // There's something in the proxy and port boxes, enable "Next".
>   ButtonFlags |= PSWIZB_NEXT;
>  }
>
>   GetOwner ()->SetButtons (ButtonFlags);
>
>   EnableWindow (GetDlgItem (IDC_PROXY_HOST), p);
>   EnableWindow (GetDlgItem (IDC_PROXY_PORT), p);
> }
>
> static void
> load_dialog (HWND h)
> {
>   rbset (h, rb, net_method);
>   eset (h, IDC_PROXY_HOST, net_proxy_host);
>   if (net_proxy_port == 0)
>     net_proxy_port = 80;
>   eset (h, IDC_PROXY_PORT, net_proxy_port);
> }
>
> static void
> save_dialog (HWND h)
> {
>   net_method = rbget (h, rb);
>   net_proxy_host = eget (h, IDC_PROXY_HOST, net_proxy_host);
>   net_proxy_port = eget (h, IDC_PROXY_PORT);
> }
>
> <<<<<<< net.cc
> bool
> NetPage::Create ()
> =======
> static BOOL
> dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)
> {
>   switch (id)
>     {
>
>     case IDC_NET_IE5:
>     case IDC_NET_DIRECT:
>     case IDC_NET_PROXY:
>     case IDC_PROXY_HOST:
>     case IDC_PROXY_PORT:
>       save_dialog (h);
>       check_if_enable_next (h);
>       break;
>     }
>   return 0;
> }
>
> bool
> NetPage::Create ()
> >>>>>>> 2.8
> {
> <<<<<<< net.cc
>   return PropertyPage::Create (IDD_NET);
> =======
>   return PropertyPage::Create (NULL, dialog_cmd, IDD_NET);
> >>>>>>> 2.8
> }
>
> void
> NetPage::OnInit ()
> {
>   HWND h = GetHWND ();
>
>   net_method = IDC_NET_DIRECT;
> <<<<<<< net.cc
>   load_dialog (h);
>   CheckIfEnableNext();
>
>   // Check to see if any radio buttons are selected. If not, select a
> default.
>   if ((!SendMessage (GetDlgItem (IDC_NET_IE5), BM_GETCHECK, 0, 0) ==
>        BST_CHECKED)
>       && (!SendMessage (GetDlgItem (IDC_NET_PROXY), BM_GETCHECK, 0, 0)
>    == BST_CHECKED))
>     {
>       SendMessage (GetDlgItem (IDC_NET_DIRECT), BM_CLICK, 0, 0);
>     }
> }
>
> <<<<<<< net.cc
> long
> NetPage::OnNext ()
> {
>   save_dialog (GetHWND ());
> =======
>   load_dialog (h);
>
>   // Check to see if any radio buttons are selected. If not, select a
> default.
>   if ((!SendMessage (GetDlgItem (IDC_NET_IE5), BM_GETCHECK, 0, 0) ==
>        BST_CHECKED)
>       && (!SendMessage (GetDlgItem (IDC_NET_PROXY), BM_GETCHECK, 0, 0)
>    == BST_CHECKED))
>     {
>       SendMessage (GetDlgItem (IDC_NET_DIRECT), BM_CLICK, 0, 0);
>     }
> }
>
> long
> NetPage::OnNext ()
> {
>   save_dialog (GetHWND ());
> >>>>>>> 2.8
>
>   log (0, "net: %s",
>        (net_method == IDC_NET_IE5) ? "IE5" :
>        (net_method == IDC_NET_DIRECT) ? "Direct" : "Proxy");
> <<<<<<< net.cc
>
>   Progress.SetActivateTask (WM_APP_START_SITE_INFO_DOWNLOAD);
>   return IDD_INSTATUS;
> }
>
> long
> NetPage::OnBack ()
> {
>   save_dialog (GetHWND ());
> =======
>     case IDC_NET_IE5:
>     case IDC_NET_DIRECT:
>     case IDC_NET_PROXY:
>     case IDC_PROXY_HOST:
>     case IDC_PROXY_PORT:
>       save_dialog (h);
>       check_if_enable_next (h);
>       break;
>
>     case IDOK:
>       save_dialog (h);
>       switch (source)
>  {
>  case IDC_SOURCE_NETINST:
>  case IDC_SOURCE_DOWNLOAD:
>    NEXT (IDD_SITE);
>    break;
>  case IDC_SOURCE_CWD:
>    NEXT (0);
>    break;
>  default:
>    msg ("source is default? %d\n", source);
>    NEXT (0);
>  }
>       break;
>
>     case IDC_BACK:
>       save_dialog (h);
>       NEXT (IDD_LOCAL_DIR);
>       break;
>
>     case IDCANCEL:
>       NEXT (0);
>       break;
>     }
> >>>>>>> 2.7
>   return 0;
> =======
>
>   Progress.SetActivateTask (WM_APP_START_SITE_INFO_DOWNLOAD);
>   return IDD_INSTATUS;
> }
>
> long
> NetPage::OnBack ()
> {
>   save_dialog (GetHWND ());
>   return 0;
> >>>>>>> 2.8
> }
>
> <<<<<<< net.cc
> bool
> NetPage::OnMessageCmd (int id, HWND hwndctl, UINT code)
> =======
> static BOOL CALLBACK
> dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)
> >>>>>>> 2.7
> {
> <<<<<<< net.cc
>   switch (id)
>     {
>     case IDC_NET_IE5:
>     case IDC_NET_DIRECT:
>     case IDC_NET_PROXY:
>     case IDC_PROXY_HOST:
>     case IDC_PROXY_PORT:
>       save_dialog (GetHWND());
>       CheckIfEnableNext ();
>       break;
>
>     default:
>       // Wasn't recognized or handled.
>       return false;
>     }
> =======
>   switch (message)
>     {
>     case WM_INITDIALOG:
>       load_dialog (h);
>
>       // Check to see if any radio buttons are selected. If not, select
> a default.
>       if (
>    (!SendMessage (GetDlgItem (h, IDC_NET_IE5), BM_GETCHECK, 0, 0) ==
>     BST_CHECKED)
>    && (!SendMessage (GetDlgItem (h, IDC_NET_PROXY), BM_GETCHECK, 0, 0)
>        == BST_CHECKED))
>  {
>    SendMessage (GetDlgItem (h, IDC_NET_DIRECT), BM_CLICK, 0, 0);
>  }
>       return FALSE;
>     case WM_COMMAND:
>       return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);
>     }
>   return FALSE;
> }
> >>>>>>> 2.7
>
> <<<<<<< net.cc
>   // Was handled since we never got to default above.
>   return true;
> =======
> void
> do_net (HINSTANCE h)
> {
>   int rv = 0;
>
>   net_method = IDC_NET_DIRECT;
>   rv = DialogBox (h, MAKEINTRESOURCE (IDD_NET), 0, dialog_proc);
>   if (rv == -1)
>     fatal (IDS_DIALOG_FAILED);
>
>   log (0, "net: %s",
>        (net_method == IDC_NET_IE5) ? "IE5" :
>        (net_method == IDC_NET_DIRECT) ? "Direct" : "Proxy");
> >>>>>>> 2.7
> }
>
>
