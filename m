Return-Path: <cygwin-patches-return-2423-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17441 invoked by alias); 13 Jun 2002 22:58:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17427 invoked from network); 13 Jun 2002 22:58:57 -0000
Message-ID: <3D092144.7060209@netscape.net>
Date: Thu, 13 Jun 2002 15:58:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: More doco updates
Content-Type: multipart/mixed;
 boundary="------------050708040403040607080703"
X-SW-Source: 2002-q2/txt/msg00406.txt.bz2


--------------050708040403040607080703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 472

Hi,

This is an update to cvs.html, which shows the examples with the new 
prompt style.  It also provides clarification on the cvs update 
procedure, since "cvs update" alone will cause the entire src tree to be 
pulled if you have "update -dP" in your ".cvsrc" file.  I've seen more 
then a few repositories which encourage people to keep that setting, so 
I have revised the update procedure to use a method which Robert 
reccommended the other day.


Cheers,
Nicholas

--------------050708040403040607080703
Content-Type: text/html;
 name="cvs.html.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cvs.html.diff"
Content-length: 1303

Index: cvs.html
===================================================================
RCS file: /cvs/cygwin/htdocs/cvs.html,v
retrieving revision 1.13
diff -u -3 -p -u -p -r1.13 cvs.html
--- cvs.html    7 Jan 2002 16:13:16 -0000   1.13
+++ cvs.html    13 Jun 2002 22:47:32 -0000
@@ -32,7 +32,7 @@ what password to use.  The password is t
 <tt>anoncvs </tt>:</p>
 
 <pre>
-bash$ cvs login
+$ cvs login
 (Logging in to anoncvs@sources.redhat.com)
 CVS password: <i>anoncvs</i>
 </pre>
@@ -48,15 +48,20 @@ again.</p>
 <p>To get the Cygwin sources, do this:
 
 <pre>
-bash$ cvs checkout winsup
+$ cvs checkout winsup
 </pre>
 
 <p>This will create a subdirectory called <tt>src</tt> and fill it
-with the core sources.  Once you have the latest sources, "<tt>cvs
-update</tt>" will get any changes since your last update.</p>
+with the core sources.</p>
 
-<p>Please refer to the <A href="http://cygwin.com/faq/">
-FAQ</a>
+<p>To keep your sources current with the latest changes in the CVS
+repository, switch to the <tt>src</tt> directory and do this:
+
+<pre>
+$ for f in *; do cvs -z3 up -Pd $f; done
+</pre>
+
+<p>Please refer to the <A href="http://cygwin.com/faq/">FAQ</A>
 for information on building cygwin.  Hint: You need to configure and
 build in a separate directory from the source.</p>
 <pre>

--------------050708040403040607080703--
