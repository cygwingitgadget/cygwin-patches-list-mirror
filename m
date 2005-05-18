Return-Path: <cygwin-patches-return-5459-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7834 invoked by alias); 18 May 2005 10:36:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7699 invoked from network); 18 May 2005 10:36:40 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 18 May 2005 10:36:40 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYLup-0001Ve-Ht
	for cygwin-patches@cygwin.com; Wed, 18 May 2005 10:36:40 +0000
Message-ID: <428B1AD4.A568D71B@dessent.net>
Date: Wed, 18 May 2005 10:36:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] update documentation Was: cygwin-host-setup does not 
 install   sshd
References: <200505171327.AA676593880@mail.rabinglove.com> <428AB86F.75BC27A0@dessent.net> <20050518081023.GN18174@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------7CEA12C23F84B273607BC890"
X-SW-Source: 2005-q2/txt/msg00055.txt.bz2

This is a multi-part message in MIME format.
--------------7CEA12C23F84B273607BC890
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 869

Corinna Vinschen wrote:

> > 2005-05-17  Brian Dessent  <brian@XXX.YYY>
> 
> http://cygwin.com/acronyms#PCYMTNQREAIYR ;-)

Yeah, I know.  Spammers have had my address for some time, I don't feel
like hiding.  Me <heart> SpamAssassin.  :)

> "Close all Cygwin command prompts, xterms, etc. and stop the X11 server [...]"
> 
> one item up and then to begin the next item with
> 
> "Open a single Cygwin command promt, remove all mount information with
>  @samp{umount -A} [...]"

Ah, right.  I guess I was trying to avoid saying "close down everything"
followed by "open a command prompt and..."  I combined the two steps
into one, hopefully less confusing.

2005-05-18  Brian Dessent  <brian@dessent.net>

	* install.texinfo ("How do I uninstall..."): Rewrite to cover
	removing services, dealing with permissions, and other common
	tasks for removing Cygwin completely.
--------------7CEA12C23F84B273607BC890
Content-Type: text/plain; charset=us-ascii;
 name="uninstall_cygwin_docpatch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uninstall_cygwin_docpatch.patch"
Content-length: 4339

Index: install.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/install.texinfo,v
retrieving revision 1.52
diff -u -r1.52 install.texinfo
--- install.texinfo	29 Jan 2005 22:35:17 -0000	1.52
+++ install.texinfo	18 May 2005 10:33:20 -0000
@@ -252,29 +252,59 @@
 
 @subsection How do I uninstall @strong{all} of Cygwin?
 
-Setup has no automatic uninstall facility.  Just delete everything
-manually:
+Setup has no automatic uninstall facility.  The recommended method to remove all 
+of Cygwin is as follows:
 
-@itemize @bullet
-@item Cygwin shortcuts on the Desktop and Start Menu
-
-@item The registry tree @samp{Software\Cygnus Solutions} under
-@code{HKEY_LOCAL_MACHINE} and/or @code{HKEY_CURRENT_USER}.
-
-@item Anything under the Cygwin root folder, @samp{C:\cygwin} by
-default.
-
-@item Anything created by setup in its temporary working directory.
+@enumerate
 
-@end itemize
+@item Remove all Cygwin services.  If a service is currently running, it must 
+first be stopped with @samp{cygrunsrv -E name}, where @samp{name} 
+is the name of the service.  Then use @samp{cygrunsrv -R name} to uninstall the 
+service from the registry.  Repeat this for all services that you installed.  
+Common services that might have been installed are @code{sshd}, @code{cron}, 
+@code{cygserver}, @code{inetd}, @code{apache}, and so on.
+
+@item Stop the X11 server if it is running, and terminate any Cygwin programs 
+that might be running in the background.  Remove all mount information by typing 
+@samp{umount -A} and then exit the command prompt and ensure that no Cygwin 
+processes remain.  Note: If you want to save your mount points for a later 
+reinstall, first save the output of @samp{mount -m} as described at 
+@file{http://cygwin.com/cygwin-ug-net/using-utils.html#mount}.
 
-It's up to you to deal with other changes you made to your system, such
-as installing the inetd service, altering system paths, etc.  Setup
-would not have done any of these things for you.
+@item Delete the Cygwin root folder and all subfolders.  If you get an error 
+that an object is in use, then ensure that you've stopped all services and 
+closed all Cygwin programs.  If you get a 'Permission Denied' error then you 
+will need to modify the permissions and/or ownership of the files or folders 
+that are causing the error.  For example, sometimes files used by system 
+services end up owned by the SYSTEM account and not writable by regular users.  
+
+The quickest way to delete the entire tree if you run into this problem is to 
+change the ownership of all files and folders to your account.  To do this in 
+Windows Explorer, right click on the root Cygwin folder, choose Properties, then 
+the Security tab.  Select Advanced, then go to the Owner tab and make sure your 
+account is listed as the owner.  Select the 'Replace owner on subcontainers and 
+objects' checkbox and press Ok.  After Explorer applies the changes you should 
+be able to delete the entire tree in one operation.  Note that you can also 
+achieve this in Cygwin by typing @samp{chown -R user /} or by using other tools 
+such as CACLS.EXE.
+
+@item Delete the Cygwin shortcuts on the Desktop and Start Menu, and anything 
+left by setup.exe in the download directory.  However, if you plan to reinstall 
+Cygwin it's a good idea to keep your setup.exe download directory since you can 
+reinstall the packages left in its cache without redownloading them.
+
+@item If you added Cygwin to your system path, you should remove it unless you 
+plan to reinstall Cygwin to the same location.  Similarly, if you set your 
+CYGWIN environment variable system-wide and don't plan to reinstall, you should 
+remove it.
+
+@item Finally, if you want to be thorough you can delete the registry tree 
+@samp{Software\Cygnus Solutions} under @code{HKEY_LOCAL_MACHINE} and/or 
+@code{HKEY_CURRENT_USER}.  However, if you followed the directions above you 
+will have already removed all the mount information which is typically the only 
+thing stored in the registry.
 
-If you want to save your mount points for a later reinstall, save the
-output of @samp{mount -m} as described at
-@file{http://cygwin.com/cygwin-ug-net/using-utils.html#mount}.
+@end enumerate
 
 @subsection How do I install snapshots?
 


--------------7CEA12C23F84B273607BC890--
