Return-Path: <cygwin-patches-return-1691-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23196 invoked by alias); 14 Jan 2002 07:19:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23181 invoked from network); 14 Jan 2002 07:19:56 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: <cygwin-patches@cygwin.com>
Subject: RE: Problem with winsup/cinstall compilation
Date: Sun, 13 Jan 2002 23:19:00 -0000
Message-ID: <000d01c19ccb$83a8daa0$fe6207d5@BRAMSCHE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <20020112203006.GG21924@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00048.txt.bz2

> On Sat, Jan 12, 2002 at 07:36:00PM +0100, Corinna Vinschen wrote:
> >On Sat, Jan 12, 2002 at 07:14:25PM +0100, Ralf Habacker wrote:
> >> EMail: Ralf.Habacker@saght.tessag.com
> >>>>I have looked in the cygwin ChangeLog for making a proper ChangeLog,
> >>>>but don't recognized this details.  Sorry
> >>>
> >>>http://cygwin.com/contrib.html
> >>>
> >>I have read this and I see many "what not to do statements" relating
> >>changelog.  I think it would be easier and faster to read if some true
> >>examples are included at this page.  :-)
> >
> >Isn't the ChangeLog file itself *the* example?
>
Yet, see above. But than it should be consequently used in the ChangeLogs.

from www.cygwin.com/contrib.html I found the following statement for example

Improper ChangeLog formatting:
	Multiple functions or filenames on a ChangeLog line (e.g., "* foo.cc, bar.cc: Add argument
to baf call.")

I have found about 400 several changelog entrys lines in the whole cygwin src tree (including
winsup) with this error.
Relating to the total number of entries (1146) this means that over 30% of all changelog
entries are not conform with the style guide you've told about.

You can reproduce this benchmark with the following lines:

finding all violations:

 find src -name 'ChangeLog' -exec grep ",.*:" {} \; | grep -v "[()]" | wc -l
     401

number of changelog entries:

 find src -name 'ChangeLog' -exec egrep "^[0-9]+-[0-9]+-" {} \;  | wc -l
    1146

In the winsup tree itself there are about 4 % of all entry only with this violation.

> Yes.  That and the *link to the GNU ChangeLog Standards*.
>
Yes, but the above result seems to me that more people as I have problems to know the correct
standard.

> And, regardless, I believe that Ralf's ChangeLog didn't even adhere to
> even the "what not to do statements".

Yes I've done a mistakes in spelling ("ditto.") and building full sentense "missing dot", but
I'm onot the only one.

"... full sentence" - examples missing dot at the end

2001-12-14  Christopher Faylor  <cgf@redhat.com>
        * configure: Regenerate

2001-11-03  Christopher Faylor  <cgf@redhat.com>
	* configure: Regenerate.

2000-09-02  Egor Duda  <deo@logos-m.ru>

	* Makefile.in: Add new goal "check"

Thu May 25 18:39:24 2000  Christopher Faylor <cgf@cygnus.com>

	* configure: Regenerate

2000-04-17  DJ Delorie  <dj@cygnus.com>

	* Makefile.common (srcdir): remove dependence on where pwd is

2000-01-26  DJ Delorie  <dj@cygnus.com>

	* doc/Makefile.in: fix doctool -d options

So I don't want to accuse someone, but my objectives are to make it easier specific for new
contributors to follow this rules and again putting some examples direct on this contribution
page I think would shorten the learning curve.

After Robert Collins has wrote me, that there was something wrong with this ChangeLog, I have
looked more deeply what he is meaning and now I'm ready for this task.  (I hope I remember
all very detailed issues, when I add a patch in an half year)

Regards
Ralf
