From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: the order of ACEs.
Date: Wed, 25 Apr 2001 12:03:00 -0000
Message-id: <s1sr8ygol8l.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00162.html

The `alloc_sd' puts inherited ACCESS_ALLOWED_ACEs in front of
the `everyone' ACE. It always breaks the rule of the order of
ACEs specified in the Platform SDK Document quoted below.

   To ensure that non-inherited ACEs have precedence over
   inherited ACEs, place all non-inherited ACEs in a group
   before any inherited ACEs.

I believe it causes no problem to put unrelated ALLOWED_ACEs
behind the `everyone' ACE.  Because the system can try the
`everyone' ACE even if a restricted ALLOWED_ACE doesn't allow
an access in front of it.

If so, the following patch can decrease the cases where the
Access Control Editor complains about the order of ACEs.

ChangeLog:
2001-04-26  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* security.cc (alloc_sd): Add unrelated ACCESS_ALLOWED_ACE behind
	the `everyone' ACE.

Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.43
diff -u -p -r1.43 security.cc
--- security.cc	2001/04/25 09:43:25	1.43
+++ security.cc	2001/04/25 18:18:35
@@ -622,6 +622,11 @@ alloc_sd (uid_t uid, gid_t gid, const ch
 				group_sid, acl_len, inherit))
     return NULL;
 
+  /* Set allow ACE for everyone. */
+  if (!add_access_allowed_ace (acl, ace_off++, other_allow,
+				get_world_sid (), acl_len, inherit))
+    return NULL;
+
   /* Get owner and group from current security descriptor. */
   PSID cur_owner_sid = NULL;
   PSID cur_group_sid = NULL;
@@ -649,8 +654,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
 	    continue;
 	  /*
 	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
-	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end
-	   * but in front of the `everyone' ACE.
+	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
 	   */
 	  if (!AddAce(acl, ACL_REVISION,
 		       ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
@@ -661,13 +665,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
 	      return NULL;
 	    }
 	  acl_len += ace->Header.AceSize;
-	  ++ace_off;
 	}
-
-  /* Set allow ACE for everyone. */
-  if (!add_access_allowed_ace (acl, ace_off++, other_allow,
-				get_world_sid (), acl_len, inherit))
-    return NULL;
 
   /* Set AclSize to computed value. */
   acl->AclSize = acl_len;

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
