Return-Path: <cygwin-patches-return-1639-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 993 invoked by alias); 31 Dec 2001 03:17:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 973 invoked from network); 31 Dec 2001 03:17:53 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 09 Nov 2001 06:05:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKAECACIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <062a01c19131$fb1d7000$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/txt/msg00171.txt.bz2

> Another request: please d2u all patches before you send them: The CVS
> versions are in unix format, so your patches will fail if applied on a
> linux machine.
>

NP. The official CVS can't handle text files with anything other than LF's?
Wait, don't answer that ;-(.

> Also, your indent is changing
> -bool
> -PropSheet::SetActivePageByID (int resource_id)
>
> to
>
> +bool PropSheet::SetActivePageByID (int resource_id)
>
> - and the first format is the correct one.
>

I see that, and I don't know what happened there.  I reran indent and it changed
it to the GNU way.  I know I indented, and these two functions aren't new.  Plus
all other functions in the file are indented properly.

>
> Secondly, you should run indent on all modified fiels before diffing.
> Indent created differences don't need changelog entries (unless the only
> change in a file is due to diff). site.cc is definately incorrectly
> formatted by your patch.
>

site.cc as sent has definitely been run through indent.  It's not generating the
"every line is different" problem, and looks fine to the unaided eye.  What's
not formatted correctly?  There *are* a very large number of additions and legit
changes - are you perhaps saying site.cc when you mean window.{cc,h}, which have
the "every line though identical is different to CVS" problem?

> Indent should be run with no options for cinstall. (It does the correct
> thing here).

Right, that's what I'm doing.

> However 2.2.7 is still very C++ broken. Sigh.
>
> (One specific example is:
> ===
> int
>   packagedb::installeddbread =
>   0;
> list < packagemeta, char const *,
>   strcasecmp >
>   packagedb::packages;
> list < Category, char const *,
>   strcasecmp >
>   packagedb::categories;
> PackageDBActions
>   packagedb::task =
>   PackageDB_Install;
> ===
>

Yeah.  Well, I would expect templates to cause it choke worse than this
actually; there was a time not very long ago when indent usually generated
uncompilable C++, even when thrown relatively few curves.

> Moving along to the actual patch...
> 1) Whats a TCHAR? (site.cc). Is there some reason a wchar is not
> appropriate? (i.e. Using gettext statically linked).

Last one first:  I don't think wchar_t and it's associated wstr* functions would
be appropriate at this time, since virtually nothing is currently using UNICODE.

TCHAR is a macro defined in the Windows headers that is esentially this:

#ifdef UNICODE
#define TCHAR wchar_t
#else
#define TCHAR char
#endif

This (and the plethora of other associated "FooA"/"FooW"-to-"Foo" defines, the
little-known "_tc<string.h_func>" macros, etc) allows you to do an ASCII build,
an MBCS build, or a UNICODE build from the same sources by simply defining
UNICODE (or _UNICODE, can't remember which at this moment) on your compiler
command line, and everything sorts itself out.  Using either "char" or
"wchar_t"/"WCHAR" locks you in.

Like the ChangeLog entry indicates, this is just another small step towards
internationalization of the entire app.  TCHAR et al allows that to be done
incrementally instead of en masse (somebody at MS must have been asleep at the
switch to have gotten that right! ;-)).

> 2) I don't like what you've done with the 'user URL'. The current
> implementation allows the user to add 'n' arbitrary URL's, and merge
> them with the downloaded list. I like the idea of combining the windows,
> but the capabilities must stay the same as they are now. (ie on the
> current CVS code, each time you click on 'other' the new URL is added to
> the list, and added to the select URL's.).

It actually still behaves in that same way, but right, it doesn't look like it,
nor did I really grasp that that was how it was intended to work.  I think we
need both "Add" and "Remove" in that case though.

> IOW it's not a boolean
> user-or-offical choice, it's purely a list of URLs that are known about
> and a list of select URL's. The source of the URL is irrelevant.

Well, the list of "known-about" URLs is definitely a two-part thing though: the
ones that get downloaded fresh every time you run setup, and the ones that the
user added, which I presume would be persistent across runs.  The first wouldn't
presumably be subject to "Remove", while the second would pretty much require
it, and we'd need to have some way to inform the user of the difference
(different colors in the same list box perhaps?).  I'll think on this, but I get
your drift - the combo box and radio buttons aren't an appropriate UI for the
intended functionality.  Shoot.

> 3) If other.[cc|h] is not needed, we should rm them.
>

Right, sorry, forgot to request that in the post.  They are not required for the
submitted patch; but then going to, say, an "Add new URL" button is going to
need a dialog box from somewhere....

> Other than that it looks good, if you can explain 1) to me :], correct
> 2) and answer 3) and then send a new diff, with all modified files
> indented, I'll re-review 2) and check it in. If you want to split out
> the other changes from 2) and do two patches the other stuff can go in
> without any more round trips.
>

Let me think on the last one.  I think we're probably going to need the dialog
back, just not in the "Next/Back" form that it was in.

--
Gary R. Van Sickle
Brewer.  Patriot.
