Return-Path: <cygwin-patches-return-1650-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14198 invoked by alias); 3 Jan 2002 09:46:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14184 invoked from network); 3 Jan 2002 09:46:40 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Thu, 03 Jan 2002 01:46:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKKEDICIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C19409.3F280B50"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <08d701c19438$cbf8bc80$0200a8c0@lifelesswks>
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00007.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C19409.3F280B50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1139

> -----Original Message-----
> From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> Sent: Thursday, January 03, 2002 3:27 AM
> To: Jan Nieuwenhuizen; Gary R. Van Sickle
> Cc: cygwin-patches@cygwin.com
> Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf
> packages]
>
>
> Right.  I completley naffed my sandbox with Gary's work in it :[.
>
> Gary... can I please have that missing bit of the changelog?
>
> Jan, I'll get your patch in straight after I commit Gary's.
>

Attached, but see my last comment in my previous post - it appears to be broken
as far as downloading setup.ini now.  Don't know if it's you or me or what yet.

Will also send a new diff against a current cvs update as soon the load average
goes down and I can get in, if that will be of any help.  Otherwise feel free to
ignore it, there's only one non-cvs-diff-related change, in Makefile.in (and
this line is *not* in the attached changelog on the assumption you won't need
the patch):

	* Makefile.in (iniparse.cc iniparse.h): Change "@mv iniparse.cc.h iniparse.h"
to "@mv iniparse.hh iniparse.h".

--
Gary R. Van Sickle
Brewer.  Patriot.

------=_NextPart_000_0005_01C19409.3F280B50
Content-Type: application/octet-stream;
	name="ChangeLog.setup.grvs"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.setup.grvs"
Content-length: 4700

2001-12-30  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>=0A=
=0A=
	* res.rc: Resize and rearrange property page dialog templates=0A=
	to bring them in line with "Microsoft's Backward Compatible Wizard 97"=0A=
	specification.=0A=
	(IDD_SITE): Add an edit control and an "Add" button in order to=0A=
	combine the IDD_SITE and IDD_OTHER_URL functionality onto one page.=0A=
	(IDD_OTHER_URL): Remove dialog template.=0A=
	(IDD_DLSTATUS): Remove dialog template.=0A=
=0A=
	* propsheet.cc (PropSheetProc): New function.  Add minimize box=0A=
	here instead of in PropertyPage::DialogProc.=0A=
	(PropSheet::Create): Change to use creation callback PropSheetProc.=0A=
	(DLGTEMPLATEEX): Add 'hidden' Windows struct definition.=0A=
=0A=
	* propsheet.h: Run indent.=0A=
	* proppage.h: Run indent.=0A=
=0A=
	* proppage.cc (PropertyPage::DialogProc): Remove minimize-box-adding=0A=
	functionality.  Remove commented-out "PropSheet_SetWizButtons" calls.=0A=
	Add support for calling virtual OnMessageCmd.  Add setting of fonts in=0A=
	WM_INITDIALOG handler.=0A=
	(resource.h): New include for resource IDs.=0A=
=0A=
	* site.cc (SitePage::OnBack): Remove NEXT() macro invocation.=0A=
	(SitePage::OnActivate): New member function.=0A=
	(load_dialog): Remove.  Functionality subsumed into=0A=
	SitePage::OnActivate.=0A=
	(save_dialog): Change to support both list and user URLs.  Remove=0A=
	OTHER_IDX and mirror_idx logic.=0A=
	(SitePage::PopulateListBox): New member function.=0A=
	(SitePage::CheckControlsAndDisableAccordingly): New member function.=0A=
	(SitePage::OnMessageCmd): New override.=0A=
	(check_if_enable_next): Remove.=0A=
	(dialog_cmd): Remove.=0A=
	(do_download_site_info_thread): Remove calls to NEXT() macro.=0A=
	(SitePage::Create): Call the single-param PropertyPage::Create=0A=
	overload.=0A=
	(other_url): New static taken from other.cc.=0A=
	(SitePage::OnNext): Remove mirror_idx logic.=0A=
	(SitePage::OnInit): Remove "Other URL" entry from list box.  Remove=0A=
	list box populating code, now handled in SitePage::PopulateListBox.=0A=
	(mirror_idx, NO_IDX, OTHER_IDX): Remove.=0A=
	(save_site_url): Fix potential buffer overflow problem.  Switched to=0A=
	TCHAR in grossly premature preparation for multilingual support.=0A=
	* site.h (SitePage::OnActivate): New member function.=0A=
	(SitePage::CheckControlsAndDisableAccordingly) New member.=0A=
	(SitePage::OnMessageCmd): New override.=0A=
	(do_download_site_info_thread): Add MessageBox call on failure to=0A=
	download site list.=0A=
=0A=
	* splash.cc (SplashPage::OnInit): Set the font for the title.=0A=
=0A=
	* window.h (Window::IsButtonChecked): New member function declaration.=0A=
	(Window::OnMessageCmd): New member function.=0A=
	(Window::SetDlgItemFont): New member function declaration.=0A=
	(Window::MAXFONTS, Window::Fonts, Window::FontCounter): New data=0A=
	members.=0A=
	* window.cc (Window::IsButtonChecked): New member function definition.=0A=
	(Window::SetDlgItemFont): New member function definition.=0A=
	(Window::Window): Add initialization for FontCounter.=0A=
	(Window::~Window): Delete any fonts we created.=0A=
=0A=
	* desktop.cc (etc_profile): Remove "test -f ./.bashrc && . ./.bashrc"=0A=
	from the generated /etc/profile.  Bash will source this file=0A=
	automatically, and having this here merely results in .bashrc being=0A=
	executed twice.=0A=
=0A=
	* geturl.cc (progress): Remove the "3" field width from the "%3d"=0A=
	percent-complete format indicator.  Causes line to not start at=0A=
	beginning of text box, and does little to help with "jumping", since=0A=
	the "bytes downloaded so far" field is variable-width anyway.  Change=0A=
	kb/s format field to "%03.1" to 0-pad the kb/s number in the event of=0A=
	painfully slow connections, or temporary slowdowns in faster=0A=
	connections should such more-instantaneous functionality become=0A=
	available.=0A=
=0A=
	* net.h (NetPage::OnMessageCmd): New member function declaration.=0A=
	(NetPage::CheckIfEnableNext): New member function declaration.=0A=
	* net.cc (NetPage::OnMessageCmd): New member function definition.=0A=
	(dialog_cmd): Remove, subsumed into NetPage::OnMessageCmd.=0A=
	(check_if_enable_next): Remove.=0A=
	(NetPage::CheckIfEnableNext): New member function, subsumes=0A=
	check_if_enable_next.=0A=
	(propsheet.h): Add include.=0A=
	(NetPage::Init): Add call to CheckIfEnableNext.=0A=
	(load_dialog): Remove call to check_if_enable_next.=0A=
	(NetPage::Create): Call single-template-ID-parameter overload of=0A=
	PropertyPage::Create instead of three-parameter one.=0A=
=0A=
	* Makefile.in (OBJS): Remove other.o.=0A=
	* other.cc: Remove file.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

------=_NextPart_000_0005_01C19409.3F280B50--
