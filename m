Return-Path: <cygwin-patches-return-4907-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9563 invoked by alias); 21 Aug 2004 15:07:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9553 invoked from network); 21 Aug 2004 15:07:52 -0000
Date: Sat, 21 Aug 2004 15:07:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fhandler_disk_file::fchmod
Message-ID: <20040821150818.GD27978@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040821094631.007dee80@incoming.verizon.net> <20040821135321.GB9451@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821135321.GB9451@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00059.txt.bz2

On Aug 21 09:53, Christopher Faylor wrote:
> On Sat, Aug 21, 2004 at 09:46:31AM -0400, Pierre A. Humblet wrote:
> >This bug was found while investigating testsuite failures.  It occurs
> >only on 9x, when ntsec is on.  An alternate (more general) solution
> >would be to only set allow_ntsec (in environ.cc) on NT.  Why allow it
> >on 9x?
> 
> That was my first reaction on looking at your patch before reading the
> above comment.
> 
> Why don't we do that?  It seems like it would simplify things slightly
> throughout cygwin.

allow_ntsec is only set to true on NT by default.  The above problem can
only occur if somebody explicitely sets CYGWIN=ntsec on a 9x system (sic).

What about this:

	* environ.cc (set_ntea): New function.
	(set_ntsec): Ditto.
	(set_smbntsec): Ditto.
	(parse_thing): Change ntea, ntsec and smbntsec settings to call
	appropriate functions.

Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.100
diff -u -p -r1.100 environ.cc
--- environ.cc	28 May 2004 19:50:05 -0000	1.100
+++ environ.cc	21 Aug 2004 15:05:36 -0000
@@ -482,6 +482,24 @@ set_chunksize (const char *buf)
   wincap.set_chunksize (strtol (buf, NULL, 0));
 }
 
+static void
+set_ntea (const char *buf)
+{
+  allow_ntea = (buf && strcasematch (buf, "yes") && wincap.has_security ());
+}
+
+static void
+set_ntsec (const char *buf)
+{
+  allow_ntsec = (buf && strcasematch (buf, "yes") && wincap.has_security ());
+}
+
+static void
+set_smbntsec (const char *buf)
+{
+  allow_smbntsec = (buf && strcasematch (buf, "yes") && wincap.has_security ());
+}
+
 /* The structure below is used to set up an array which is used to
    parse the CYGWIN environment variable or, if enabled, options from
    the registry.  */
@@ -516,9 +534,9 @@ static struct parse_thing
   {"export", {&export_settings}, justset, NULL, {{false}, {true}}},
   {"forkchunk", {func: set_chunksize}, isfunc, NULL, {{0}, {0}}},
   {"glob", {func: &glob_init}, isfunc, NULL, {{0}, {s: "normal"}}},
-  {"ntea", {&allow_ntea}, justset, NULL, {{false}, {true}}},
-  {"ntsec", {&allow_ntsec}, justset, NULL, {{false}, {true}}},
-  {"smbntsec", {&allow_smbntsec}, justset, NULL, {{false}, {true}}},
+  {"ntea", {func: set_ntea}, isfunc, NULL, {{0}, {s: "yes"}}},
+  {"ntsec", {func: set_ntsec}, isfunc, NULL, {{0}, {s: "yes"}}},
+  {"smbntsec", {func: set_smbntsec}, isfunc, NULL, {{0}, {s: "yes"}}},
   {"reset_com", {&reset_com}, justset, NULL, {{false}, {true}}},
   {"strip_title", {&strip_title_path}, justset, NULL, {{false}, {true}}},
   {"subauth_id", {func: &subauth_id_init}, isfunc, NULL, {{0}, {0}}},


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
