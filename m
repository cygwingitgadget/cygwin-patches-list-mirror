Return-Path: <cygwin-patches-return-1847-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13968 invoked by alias); 7 Feb 2002 13:56:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13929 invoked from network); 7 Feb 2002 13:56:32 -0000
Date: Thu, 07 Feb 2002 05:58:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: connect patch
Message-ID: <20020207145625.X14241@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>,
	Cygwin-Patches <cygwin-patches@sources.redhat.com>
References: <20020206180727.GA504@dothill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020206180727.GA504@dothill.com>
User-Agent: Mutt/1.3.22.1i
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by cygnus.com id FAA17789
X-SW-Source: 2002-q1/txt/msg00204.txt.bz2

On Wed, Feb 06, 2002 at 01:07:28PM -0500, Jason Tishler wrote:
> The attached patch fixes a SEGV when getsockname () is called.  This
> problem can be tickled by the PostgreSQL 7.2 version of psql:
>=20
>     http://archives.postgresql.org/pgsql-cygwin/2002-02/msg00012.php
>=20
> Note that I essentially plagiarized the following commit:
>=20
>     http://cygwin.com/ml/cygwin-cvs/2002-q1/msg00028.html
>=20
> Was this the right thing to do?

The patch isn't correct since it now calls fdsock() twice which allocates
a new fhandler even if the line before already had created one.

Better:

  fhandler_socket* res_fh =3D fdsock (fd, name, soc)->set_addr_family (af);
  if (af =3D=3D AF_LOCAL)
    res_fh->set_sun_path (name);

However, I don't understand the need for that patch.  Does postgresql
call getsockname() before calling bind()? I didn't know that that makes
sense.  Sure, it shouldn't SEGV but the returned name doesn't make
sense on non-Cygwin systems either.

A quick test on Linux returns:

[~]$ ./uds /tmp/mysocket
Before bind(): name =3D =FF=BFM`@=81=83(R`@b, returned len =3D 2
After bind() : name =3D /tmp/mysocket, returned len =3D 16

So, IMO, the correct way is to clean up cygwin_getsockname()
so that it always returns "something" instead of SEGVing.

Could you please test the below patch if that works with postgresql?

Thanks,
Corinna


	* net.cc (cygwin_getsockname): Fix handling of NULL sun_path.


Index: net.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.99
diff -u -p -r1.99 net.cc
--- net.cc	2002/01/29 13:39:41	1.99
+++ net.cc	2002/02/07 13:53:11
@@ -1375,12 +1375,17 @@ cygwin_getsockname (int fd, struct socka
 	  struct sockaddr_un *sun =3D (struct sockaddr_un *) addr;
 	  memset (sun, 0, *namelen);
 	  sun->sun_family =3D AF_LOCAL;
-	  /* According to SUSv2 "If the actual length of the address is greater
-	     than the length of the supplied sockaddr structure, the stored
-	     address will be truncated."  We play it save here so that the
-	     path always has a trailing 0 even if it's truncated. */
-	  strncpy (sun->sun_path, sock->get_sun_path (),
-		   *namelen - sizeof *sun + sizeof sun->sun_path - 1);
+
+	  if (!sock->get_sun_path ())
+	    sun->sun_path[0] =3D '\0';
+	  else
+	    /* According to SUSv2 "If the actual length of the address is
+	       greater than the length of the supplied sockaddr structure, the
+	       stored address will be truncated."  We play it save here so
+	       that the path always has a trailing 0 even if it's truncated. */
+	    strncpy (sun->sun_path, sock->get_sun_path (),
+		     *namelen - sizeof *sun + sizeof sun->sun_path - 1);
+
 	  *namelen =3D sizeof *sun - sizeof sun->sun_path
 		     + strlen (sun->sun_path) + 1;
 	  res =3D 0;

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
