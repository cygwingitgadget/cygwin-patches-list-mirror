Return-Path: <cygwin-patches-return-5456-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32733 invoked by alias); 18 May 2005 03:37:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32482 invoked from network); 18 May 2005 03:37:18 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 18 May 2005 03:37:18 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYFMs-00080m-Np; Wed, 18 May 2005 03:37:10 +0000
Message-ID: <428AB86F.75BC27A0@dessent.net>
Date: Wed, 18 May 2005 03:37:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: [patch] update documentation Was: cygwin-host-setup does not install 
 sshd
References: <200505171327.AA676593880@mail.rabinglove.com>
Content-Type: multipart/mixed;
 boundary="------------F61CDB1F6CF60FD38D6883EB"
X-SW-Source: 2005-q2/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------F61CDB1F6CF60FD38D6883EB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1776

admin wrote:
> 
> Thanks so much that worked like a charm.
> 
> >"umount -A" to remove all mounts, and then delete the cygwin install
> >directory.  Rummaging around in the registry is not recommended.
> >
> 
> http://www.cygwin.com/faq/faq_2.html#SEC20 <---  when removing the two registry values suggested there didnt work, i just removed anything, like i do when we get malware :).  I figured that would get it.
> 
> >It sounds like you still have a sshd service installed that is
> >referencing a nonexistent path.  Type "cygrunsrv -Q sshd" to see if
> >there is such a service, and if so "cygrunsrv -R ssh" and then rerun
> >ssh-host-config.
> >
> i did, and it was, and that worked.  Some values in the registry "could not be deleted"  i didnt really pay attention to which, i guess one was the running ssh server.

I have to admit, the documentation could be a little more clear about
the fact that you need to remove services.  I've also often read that
people encounter problems when trying to delete the Cygwin tree because
they encounter files with permissions that don't allow the file to be
deleted (e.g. files created by SYSTEM.)

I therefore propose the following rewrite of the "How do I uninstall all
of Cygwin" entry in the FAQ.  This version is much more wordy, I admit. 
But since it seems to come up every so often I feel a little
hand-holding in the FAQ can't hurt.  Rather than saying basically to
delete the folder and the registry key and "you're on your own for the
other stuff", this gives a list of steps that should cover everything.

2005-05-17  Brian Dessent  <brian@dessent.net>

	* install.texinfo ("How do I uninstall..."): Rewrite to cover
	removing services, dealing with permissions, and other common
	tasks for removing Cygwin completely.
--------------F61CDB1F6CF60FD38D6883EB
Content-Type: text/plain; charset=us-ascii;
 name="uninstall_cygwin_docpatch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uninstall_cygwin_docpatch.patch"
Content-length: 4232

Index: install.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/install.texinfo,v
retrieving revision 1.52
diff -u -r1.52 install.texinfo
--- install.texinfo	29 Jan 2005 22:35:17 -0000	1.52
+++ install.texinfo	18 May 2005 03:15:57 -0000
@@ -252,29 +252,60 @@
 
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
+@enumerate
 
-@item Anything created by setup in its temporary working directory.
+@item Remove all Cygwin services.  If a service is currently running, it must 
+first be stopped with @samp{cygrunsrv -E name}, where @samp{name} 
+is the name of the service.  Then use @samp{cygrunsrv -R name} to uninstall the 
+service from the registry.  Repeat this for all services that you installed.  
+Common services that might have been installed are @code{sshd}, @code{cron}, 
+@code{cygserver}, @code{inetd}, @code{apache}, and so on.
+
+@item Remove all mount information with @samp{umount -A}.  If you want to 
+save your mount points for a later reinstall, first save the output of 
+@samp{mount -m} as described at 
+@file{http://cygwin.com/cygwin-ug-net/using-utils.html#mount}.
 
-@end itemize
+@item Close all Cygwin command prompts, xterms, etc. and stop the X11 server if 
+it is running.
 
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
 


--------------F61CDB1F6CF60FD38D6883EB--
