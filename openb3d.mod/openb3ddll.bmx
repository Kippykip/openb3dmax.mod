' Copyright (c) 2014 Mark Mcvittie, Bruce A Henderson
'
' This software is provided 'as-is', without any express or implied
' warranty. In no event will the authors be held liable for any damages
' arising from the use of this software.
'
' Permission is granted to anyone to use this software for any purpose,
' including commercial applications, and to alter it and redistribute it
' freely, subject to the following restrictions:
'
'    1. The origin of this software must not be misrepresented; you must not
'    claim that you wrote the original software. If you use this software
'    in a product, an acknowledgment in the product documentation would be
'    appreciated but is not required.
'
'    2. Altered source versions must be plainly marked as such, and must not be
'    misrepresented as being the original software.
'
'    3. This notice may not be removed or altered from any source
'    distribution.
'
Strict

Import Brl.StandardIO
Import Brl.Map
Import Brl.Graphics
Import Pub.Glew
Import Pub.OpenGL ' order is important, glew before OpenGL

?Linux
Import "-ldl"
?

' Global declarations
' -------------------

Global BackBufferToTex_( tex:Byte Ptr, frame:Int )
Global BufferToTex_( tex:Byte Ptr, buffer:Byte Ptr, frame:Int )
Global CameraToTex_( tex:Byte Ptr, cam:Byte Ptr, frame:Int )
Global TexToBuffer_( tex:Byte Ptr, buffer:Byte Ptr, frame:Int )
' wrapper only
Global DepthBufferToTex_( tex:Byte Ptr, frame:Int )
Global GraphicsResize_( width:Int, height:Int )
Global SetRenderState_( capability:Int, flag:Int )
' Minib3d Only
Global MeshCullRadius_( ent:Byte Ptr, radius:Float )
' Blitz3D functions, A-Z
Global AddAnimSeq_:Int( ent:Byte Ptr, length:Int )
Global AddMesh_( mesh1:Byte Ptr, mesh2:Byte Ptr )
Global AddTriangle_:Int( surf:Byte Ptr, v0:Int, v1:Int, v2:Int )
Global AddVertex_:Int( surf:Byte Ptr, x:Float, y:Float, z:Float, u:Float, v:Float, w:Float )
Global AmbientLight_( r:Float, g:Float, b:Float )
Global AntiAlias_( samples:Int )
Global Animate_( ent:Byte Ptr, Mode:Int, speed:Float, seq:Int, trans:Int )
Global Animating_:Int( ent:Byte Ptr )
Global AnimLength_( ent:Byte Ptr )
Global AnimSeq_:Int( ent:Byte Ptr )
Global AnimTime_:Float( ent:Byte Ptr )
Global BrushAlpha_( brush:Byte Ptr, a:Float )
Global BrushBlend_( brush:Byte Ptr, blend:Int )
Global BrushColor_( brush:Byte Ptr, r:Float, g:Float, b:Float )
Global BrushFX_( brush:Byte Ptr, fx:Int )
Global BrushShininess_( brush:Byte Ptr, s:Float )
Global BrushTexture_( brush:Byte Ptr, tex:Byte Ptr, frame:Int, index:Int )
Global CameraClsColor_( cam:Byte Ptr, r:Float, g:Float, b:Float )
Global CameraClsMode_( cam:Byte Ptr, cls_depth:Int, cls_zbuffer:Int )
Global CameraFogColor_( cam:Byte Ptr, r:Float, g:Float, b:Float )
Global CameraFogMode_( cam:Byte Ptr, Mode:Int )
Global CameraFogRange_( cam:Byte Ptr, nnear:Float, nfar:Float )
Global CameraPick_:Byte Ptr( cam:Byte Ptr, x:Float, y:Float )
Global CameraProject_( cam:Byte Ptr, x:Float, y:Float, z:Float )
Global CameraProjMode_( cam:Byte Ptr, Mode:Int )
Global CameraRange_( cam:Byte Ptr, nnear:Float, nfar:Float )
Global CameraViewport_( cam:Byte Ptr, x:Int, y:Int, width:Int, height:Int )
Global CameraZoom_( cam:Byte Ptr, zoom:Float )
Global ClearCollisions_()
Global ClearSurface_( surf:Byte Ptr, clear_verts:Int, clear_tris:Int )
Global ClearTextureFilters_()
Global ClearWorld_( entities:Int, brushes:Int, textures:Int )
Global CollisionEntity_:Byte Ptr( ent:Byte Ptr, index:Int )
Global Collisions_( src_no:Int, dest_no:Int, method_no:Int, response_no:Int )
Global CollisionNX_:Float( ent:Byte Ptr, index:Int )
Global CollisionNY_:Float( ent:Byte Ptr, index:Int )
Global CollisionNZ_:Float( ent:Byte Ptr, index:Int )
Global CollisionSurface_:Byte Ptr( ent:Byte Ptr, index:Int )
Global CollisionTime_:Float( ent:Byte Ptr, index:Int )
Global CollisionTriangle_:Int( ent:Byte Ptr, index:Int )
Global CollisionX_:Float( ent:Byte Ptr, index:Int )
Global CollisionY_:Float( ent:Byte Ptr, index:Int )
Global CollisionZ_:Float( ent:Byte Ptr, index:Int )
Global CountChildren_:Int( ent:Byte Ptr )
Global CountCollisions_:Int( ent:Byte Ptr )
Global CopyEntity_:Byte Ptr( ent:Byte Ptr, parent:Byte Ptr )
Global CopyMesh_:Byte Ptr( mesh:Byte Ptr, parent:Byte Ptr )
Global CountSurfaces_:Int( mesh:Byte Ptr )
Global CountTriangles_:Int( surf:Byte Ptr )
Global CountVertices_:Int( surf:Byte Ptr )
Global CreateBlob_:Byte Ptr( fluid:Byte Ptr, radius:Float, parent_ent:Byte Ptr )
Global CreateBrush_:Byte Ptr( r:Float, g:Float, b:Float )
Global CreateCamera_:Byte Ptr( parent:Byte Ptr )
Global CreateCone_:Byte Ptr( segments:Int, solid:Int, parent:Byte Ptr )
Global CreateCylinder_:Byte Ptr( segments:Int, solid:Int, parent:Byte Ptr )
Global CreateCube_:Byte Ptr( parent:Byte Ptr )
Global CreateFluid_:Byte Ptr()
Global CreateGeosphere_:Byte Ptr( size:Int, parent:Byte Ptr )
Global CreateMesh_:Byte Ptr( parent:Byte Ptr )
Global CreateLight_:Byte Ptr( light_type:Int, parent:Byte Ptr )
Global CreatePivot_:Byte Ptr( parent:Byte Ptr )
Global CreatePlane_:Byte Ptr( divisions:Int, parent:Byte Ptr )
Global CreateQuad_:Byte Ptr( parent:Byte Ptr )
Global CreateShadow_:Byte Ptr( parent:Byte Ptr, Static:Int )
Global CreateSphere_:Byte Ptr( segments:Int, parent:Byte Ptr )
Global CreateSprite_:Byte Ptr( parent:Byte Ptr )
Global CreateSurface_:Byte Ptr( mesh:Byte Ptr, brush:Byte Ptr )
Global CreateStencil_:Byte Ptr()
Global CreateTerrain_:Byte Ptr( size:Int, parent:Byte Ptr )
Global CreateTexture_:Byte Ptr( width:Int, height:Int, flags:Int, frames:Int )
Global CreateVoxelSprite_:Byte Ptr( slices:Int, parent:Byte Ptr )
Global DeltaPitch_:Float( ent1:Byte Ptr, ent2:Byte Ptr )
Global DeltaYaw_:Float( ent1:Byte Ptr, ent2:Byte Ptr )
Global EntityAlpha_( ent:Byte Ptr, alpha:Float )
Global EntityAutoFade_( ent:Byte Ptr, near:Float, far:Float )
Global EntityBlend_( ent:Byte Ptr, blend:Int )
Global EntityBox_( ent:Byte Ptr, x:Float, y:Float, z:Float, w:Float, h:Float, d:Float )
Global EntityClass_:Byte Ptr( ent:Byte Ptr )
Global EntityCollided_:Byte Ptr( ent:Byte Ptr, type_no:Int )
Global EntityColor_( ent:Byte Ptr, red:Float, green:Float, blue:Float )
Global EntityDistance_:Float( ent1:Byte Ptr, ent2:Byte Ptr )
Global EntityFX_( ent:Byte Ptr, fx:Int )
Global EntityInView_:Int( ent:Byte Ptr, cam:Byte Ptr )
Global EntityName_:Byte Ptr( ent:Byte Ptr )
Global EntityOrder_( ent:Byte Ptr, order:Int )
Global EntityParent_( ent:Byte Ptr, parent_ent:Byte Ptr, glob:Int )
Global EntityPick_:Byte Ptr( ent:Byte Ptr, Range:Float )
Global EntityPickMode_( ent:Byte Ptr, pick_mode:Int, obscurer:Int )
Global EntityPitch_:Float( ent:Byte Ptr, glob:Int )
Global EntityRadius_( ent:Byte Ptr, radius_x:Float, radius_y:Float )
Global EntityRoll_:Float( ent:Byte Ptr, glob:Int )
Global EntityShininess_( ent:Byte Ptr, shine:Float )
Global EntityTexture_( ent:Byte Ptr, tex:Byte Ptr, frame:Int, index:Int )
Global EntityType_( ent:Byte Ptr, type_no:Int, recursive:Int )
Global EntityVisible_:Int( src_ent:Byte Ptr, dest_ent:Byte Ptr )
Global EntityX_:Float( ent:Byte Ptr, glob:Int )
Global EntityY_:Float( ent:Byte Ptr, glob:Int )
Global EntityYaw_:Float( ent:Byte Ptr, glob:Int )
Global EntityZ_:Float( ent:Byte Ptr, glob:Int )
Global ExtractAnimSeq_:Int( ent:Byte Ptr, first_frame:Int, last_frame:Int, seq:Int )
Global FindChild_:Byte Ptr( ent:Byte Ptr, child_name:Byte Ptr )
Global FindSurface_:Byte Ptr( mesh:Byte Ptr, brush:Byte Ptr )
Global FitMesh_( mesh:Byte Ptr, x:Float, y:Float, z:Float, width:Float, height:Float, depth:Float, uniform:Int )
Global FlipMesh_( mesh:Byte Ptr )
Global FreeBrush_( brush:Byte Ptr )
Global FreeEntity_( ent:Byte Ptr )
Global FreeShadow_( shad:Byte Ptr )
Global FreeTexture_( tex:Byte Ptr )
Global GeosphereHeight_( geo:Byte Ptr, h:Float )
Global GetBrushTexture_:Byte Ptr( brush:Byte Ptr, index:Int )
Global GetChild_:Byte Ptr( ent:Byte Ptr, child_no:Int )
Global GetEntityBrush_:Byte Ptr( ent:Byte Ptr )
Global GetEntityType_:Int( ent:Byte Ptr )
Global GetMatElement_:Float( ent:Byte Ptr, row:Int, col:Int )
Global GetParentEntity_:Byte Ptr( ent:Byte Ptr )
Global GetSurface_:Byte Ptr( mesh:Byte Ptr, surf_no:Int )
Global GetSurfaceBrush_:Byte Ptr( surf:Byte Ptr )	
Global Graphics3D_( width:Int, height:Int, depth:Int, Mode:Int, rate:Int )
Global HandleSprite_( sprite:Byte Ptr, h_x:Float, h_y:Float )
Global HideEntity_( ent:Byte Ptr )
Global LightColor_( light:Byte Ptr, red:Float, green:Float, blue:Float )
Global LightConeAngles_( light:Byte Ptr, inner_ang:Float, outer_ang:Float )
Global LightRange_( light:Byte Ptr, Range:Float )
Global LinePick_:Byte Ptr( x:Float, y:Float, z:Float, dx:Float, dy:Float, dz:Float, radius:Float )
Global LoadAnimMesh_:Byte Ptr( file:Byte Ptr, parent:Byte Ptr )
Global LoadAnimTexture_:Byte Ptr( file:Byte Ptr, flags:Int, frame_width:Int, frame_height:Int, first_frame:Int, frame_count:Int )
Global LoadBrush_:Byte Ptr( file:Byte Ptr, flags:Int, u_scale:Float, v_scale:Float )
Global LoadGeosphere_:Byte Ptr( file:Byte Ptr, parent:Byte Ptr )
Global LoadMesh_:Byte Ptr( file:Byte Ptr, parent:Byte Ptr )
Global LoadTerrain_:Byte Ptr( file:Byte Ptr, parent:Byte Ptr )
Global LoadTexture_:Byte Ptr( file:Byte Ptr, flags:Int )
Global LoadSprite_:Byte Ptr( tex_file:Byte Ptr, tex_flag:Int, parent:Byte Ptr )
Global MeshCSG_:Byte Ptr( m1:Byte Ptr, m2:Byte Ptr, method_no:Int )
Global MeshDepth_:Float( mesh:Byte Ptr )
Global MeshesIntersect_:Int( mesh1:Byte Ptr, mesh2:Byte Ptr )
Global MeshHeight_:Float( mesh:Byte Ptr )
Global MeshWidth_:Float( mesh:Byte Ptr )
Global ModifyGeosphere_( geo:Byte Ptr, x:Int, z:Int, new_height:Float )
Global ModifyTerrain_( terr:Byte Ptr, x:Int, z:Int, new_height:Float )
Global MoveEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float )
Global NameEntity_( ent:Byte Ptr, name:Byte Ptr )
Global PaintEntity_( ent:Byte Ptr, brush:Byte Ptr )
Global PaintMesh_( mesh:Byte Ptr, brush:Byte Ptr )
Global PaintSurface_( surf:Byte Ptr, brush:Byte Ptr )
Global PickedEntity_:Byte Ptr()
Global PickedNX_:Float()
Global PickedNY_:Float()
Global PickedNZ_:Float()
Global PickedSurface_:Byte Ptr()
Global PickedTime_:Float()
Global PickedTriangle_:Int()
Global PickedX_:Float()
Global PickedY_:Float()
Global PickedZ_:Float()
Global PointEntity_( ent:Byte Ptr, target_ent:Byte Ptr, roll:Float )
Global PositionEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )
Global PositionMesh_( mesh:Byte Ptr, px:Float, py:Float, pz:Float )
Global PositionTexture_( tex:Byte Ptr, u_pos:Float, v_pos:Float )
Global ProjectedX_:Float()
Global ProjectedY_:Float()
Global ProjectedZ_:Float()
Global RenderWorld_()
Global RepeatMesh_:Byte Ptr( mesh:Byte Ptr, parent:Byte Ptr )
Global ResetEntity_( ent:Byte Ptr )
Global RotateEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )
Global RotateMesh_( mesh:Byte Ptr, pitch:Float, yaw:Float, roll:Float )
Global RotateSprite_( sprite:Byte Ptr, ang:Float )
Global RotateTexture_( tex:Byte Ptr, ang:Float )
Global ScaleEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )
Global ScaleMesh_( mesh:Byte Ptr, sx:Float, sy:Float, sz:Float )
Global ScaleSprite_( sprite:Byte Ptr, s_x:Float, s_y:Float )
Global ScaleTexture_( tex:Byte Ptr, u_scale:Float, v_scale:Float )
Global SetAnimTime_( ent:Byte Ptr, time:Float, seq:Int )
Global SetCubeFace_( tex:Byte Ptr, face:Int )
Global SetCubeMode_( tex:Byte Ptr, Mode:Int )
Global ShowEntity_( ent:Byte Ptr )
Global SpriteRenderMode_( sprite:Byte Ptr, Mode:Int )
Global SpriteViewMode_( sprite:Byte Ptr, Mode:Int )
Global StencilAlpha_( stencil:Byte Ptr, a:Float )
Global StencilClsColor_( stencil:Byte Ptr, r:Float, g:Float, b:Float )
Global StencilClsMode_( stencil:Byte Ptr, cls_depth:Int, cls_zbuffer:Int )
Global StencilMesh_( stencil:Byte Ptr, mesh:Byte Ptr, Mode:Int )
Global StencilMode_( stencil:Byte Ptr, m:Int, o:Int )
Global TerrainHeight_:Float( terr:Byte Ptr, x:Int, z:Int )
Global TerrainX_:Float( terr:Byte Ptr, x:Float, y:Float, z:Float )
Global TerrainY_:Float( terr:Byte Ptr, x:Float, y:Float, z:Float )
Global TerrainZ_:Float( terr:Byte Ptr, x:Float, y:Float, z:Float )
Global TextureBlend_( tex:Byte Ptr, blend:Int )
Global TextureCoords_( tex:Byte Ptr, coords:Int )
Global TextureHeight_:Int( tex:Byte Ptr )
Global TextureFilter_( match_text:Byte Ptr, flags:Int )
Global TextureName_:Byte Ptr( tex:Byte Ptr )
Global TextureWidth_:Int( tex:Byte Ptr )
Global TFormedX_:Float()
Global TFormedY_:Float()
Global TFormedZ_:Float()
Global TFormNormal_( x:Float, y:Float, z:Float, src_ent:Byte Ptr, dest_ent:Byte Ptr )
Global TFormPoint_( x:Float, y:Float, z:Float, src_ent:Byte Ptr, dest_ent:Byte Ptr )
Global TFormVector_( x:Float, y:Float, z:Float, src_ent:Byte Ptr, dest_ent:Byte Ptr )
Global TranslateEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )
Global TriangleVertex_:Int( surf:Byte Ptr, tri_no:Int, corner:Int )
Global TurnEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )
Global UpdateNormals_( mesh:Byte Ptr )
Global UpdateTexCoords_( surf:Byte Ptr )
Global UpdateWorld_( anim_speed:Float )
Global UseStencil_( stencil:Byte Ptr )
Global VectorPitch_:Float( vx:Float, vy:Float, vz:Float )
Global VectorYaw_:Float( vx:Float, vy:Float, vz:Float )
Global VertexAlpha_:Float( surf:Byte Ptr, vid:Int )
Global VertexBlue_:Float( surf:Byte Ptr, vid:Int )
Global VertexColor_( surf:Byte Ptr, vid:Int, r:Float, g:Float, b:Float, a:Float )
Global VertexCoords_( surf:Byte Ptr, vid:Int, x:Float, y:Float, z:Float )
Global VertexGreen_:Float( surf:Byte Ptr, vid:Int )
Global VertexNormal_( surf:Byte Ptr, vid:Int, nx:Float, ny:Float, nz:Float )
Global VertexNX_:Float( surf:Byte Ptr, vid:Int )
Global VertexNY_:Float( surf:Byte Ptr, vid:Int )
Global VertexNZ_:Float( surf:Byte Ptr, vid:Int )
Global VertexRed_:Float( surf:Byte Ptr, vid:Int )
Global VertexTexCoords_( surf:Byte Ptr, vid:Int, u:Float, v:Float, w:Float, coord_set:Int )
Global VertexU_:Float( surf:Byte Ptr, vid:Int, coord_set:Int )
Global VertexV_:Float( surf:Byte Ptr, vid:Int, coord_set:Int )
Global VertexW_:Float( surf:Byte Ptr, vid:Int, coord_set:Int )
Global VertexX_:Float( surf:Byte Ptr, vid:Int )
Global VertexY_:Float( surf:Byte Ptr, vid:Int )
Global VertexZ_:Float( surf:Byte Ptr, vid:Int )
Global VoxelSpriteMaterial_( voxelspr:Byte Ptr, mat:Byte Ptr )
Global Wireframe_( enable:Int )
' ***extras***
Global EntityScaleX_:Float( ent:Byte Ptr, glob:Int )
Global EntityScaleY_:Float( ent:Byte Ptr, glob:Int )
Global EntityScaleZ_:Float( ent:Byte Ptr, glob:Int )
Global LoadShader_:Byte Ptr( ShaderName:Byte Ptr, VshaderFileName:Byte Ptr, FshaderFileName:Byte Ptr )
Global CreateShader_:Byte Ptr( ShaderName:Byte Ptr, VshaderString:Byte Ptr, FshaderString:Byte Ptr )
Global ShadeSurface_( surf:Byte Ptr, material:Byte Ptr )
Global ShadeMesh_( mesh:Byte Ptr, material:Byte Ptr )
Global ShadeEntity_( ent:Byte Ptr, material:Byte Ptr )
Global ShaderTexture_( material:Byte Ptr, tex:Byte Ptr, name:Byte Ptr, index:Int )
Global SetFloat_( material:Byte Ptr, name:Byte Ptr, v1:Float )
Global SetFloat2_( material:Byte Ptr, name:Byte Ptr, v1:Float, v2:Float )
Global SetFloat3_( material:Byte Ptr, name:Byte Ptr, v1:Float, v2:Float, v3:Float )
Global SetFloat4_( material:Byte Ptr, name:Byte Ptr, v1:Float, v2:Float, v3:Float, v4:Float )
Global UseFloat_( material:Byte Ptr, name:Byte Ptr, v1:Float Ptr )
Global UseFloat2_( material:Byte Ptr, name:Byte Ptr, v1:Float Ptr, v2:Float Ptr )
Global UseFloat3_( material:Byte Ptr, name:Byte Ptr, v1:Float Ptr, v2:Float Ptr, v3:Float Ptr )
Global UseFloat4_( material:Byte Ptr, name:Byte Ptr, v1:Float Ptr, v2:Float Ptr, v3:Float Ptr, v4:Float Ptr )
Global SetInteger_( material:Byte Ptr, name:Byte Ptr, v1:Int )
Global SetInteger2_( material:Byte Ptr, name:Byte Ptr, v1:Int, v2:Int )
Global SetInteger3_( material:Byte Ptr, name:Byte Ptr, v1:Int, v2:Int, v3:Int )
Global SetInteger4_( material:Byte Ptr, name:Byte Ptr, v1:Int, v2:Int, v3:Int, v4:Int )
Global UseInteger_( material:Byte Ptr, name:Byte Ptr, v1:Int Ptr )
Global UseInteger2_( material:Byte Ptr, name:Byte Ptr, v1:Int Ptr, v2:Int Ptr )
Global UseInteger3_( material:Byte Ptr, name:Byte Ptr, v1:Int Ptr, v2:Int Ptr, v3:Int Ptr )
Global UseInteger4_( material:Byte Ptr, name:Byte Ptr, v1:Int Ptr, v2:Int Ptr, v3:Int Ptr, v4:Int Ptr )
Global UseSurface_( material:Byte Ptr, name:Byte Ptr, surf:Byte Ptr, vbo:Int )
Global UseMatrix_( material:Byte Ptr, name:Byte Ptr, Mode:Int )
Global LoadMaterial_:Byte Ptr( filename:Byte Ptr, flags:Int, frame_width:Int, frame_height:Int, first_frame:Int, frame_count:Int )
Global ShaderMaterial_( material:Byte Ptr, tex:Byte Ptr, name:Byte Ptr, index:Int )
Global CreateOcTree_:Byte Ptr( w:Float, h:Float, d:Float, parent_ent:Byte Ptr )
Global OctreeBlock_( octree:Byte Ptr, mesh:Byte Ptr, level:Int, X:Float, Y:Float, Z:Float, Near:Float, Far:Float )
Global OctreeMesh_( octree:Byte Ptr, mesh:Byte Ptr, level:Int, X:Float, Y:Float, Z:Float, Near:Float, Far:Float )

Private

Global libDirs$[] = ["" , CurrentDir()+"/" , "BlitzMax/mod/angros.mod/openb3d.mod/"] ' install location
Global hLib:Int
Global globals:TGlobal=New TGlobal

Public

' Library functions
' -----------------

?Win32
Extern "win32"
	Function LoadLibraryA( dll$z )
	Function GetProcAddress:Byte Ptr( libhandle:Int, func$z )
End Extern
?Not Win32
Extern
	Function dlopen( path$z, Mode:Int )
	Function dlsym:Byte Ptr( dl:Int, sym$z )
	Function dlclose( dl:Int )
End Extern
?

Function dlAddress:Byte Ptr( str$ )

	Local proc:Byte Ptr
?Win32
	proc=GetProcAddress( hLib,str )
?Not Win32
	proc=dlsym( hLib,str )
?
	If proc Return proc
	Print "Error: Can't find symbol:"+str
	End
	
End Function

Function OpenLibrary()

	If hLib Return
	Local lib:String
		
	For Local path:String = EachIn libDirs
		lib=path
?Win32
		hLib=LoadLibraryA( "libopenb3d.dll" )
?Macos
		hLib=dlopen( "libopenb3d.dylib",1 ) 
?Linux
		hLib=dlopen( "libopenb3d.so",1 )
?
	
		If Not hLib Then
?Win32
			lib:+"libopenb3d.dll"
			hLib=LoadLibraryA( lib )
?Macos
			lib:+"libopenb3d.dylib"
			hLib=dlopen( lib,1 )
?Linux
			lib:+"libopenb3d.so"
			hLib=dlopen( lib,1 ) 
?
		EndIf
		If hLib Then Exit
	Next
	
	If Not hLib
		Print "Error: Can't open lib:"+lib
		End
	EndIf
	
	BackBufferToTex_ = dlAddress("BackBufferToTex")
	BufferToTex_ = dlAddress("BufferToTex")
	CameraToTex_ = dlAddress("CameraToTex")
	TexToBuffer_ = dlAddress("TexToBuffer")
	' wrapper only
	DepthBufferToTex_ = dlAddress("DepthBufferToTex")
	GraphicsResize_ = dlAddress("GraphicsResize")
	SetRenderState_ = dlAddress("SetRenderState")
	' Minib3d Only
	MeshCullRadius_ = dlAddress("MeshCullRadius")
	' Blitz3D functions, A-Z
	AddAnimSeq_ = dlAddress("AddAnimSeq")
	AddMesh_ = dlAddress("AddMesh")
	AddTriangle_ = dlAddress("AddTriangle")
	AddVertex_ = dlAddress("AddVertex")
	AmbientLight_ = dlAddress("AmbientLight")
	AntiAlias_ = dlAddress("AntiAlias")
	Animate_ = dlAddress("Animate")
	Animating_ = dlAddress("Animating")
	AnimLength_ = dlAddress("AnimLength")
	AnimSeq_ = dlAddress("AnimSeq")
	AnimTime_ = dlAddress("AnimTime")
	BrushAlpha_ = dlAddress("BrushAlpha")
	BrushBlend_ = dlAddress("BrushBlend")
	BrushColor_ = dlAddress("BrushColor")
	BrushFX_ = dlAddress("BrushFX")
	BrushShininess_ = dlAddress("BrushShininess")
	BrushTexture_ = dlAddress("BrushTexture")
	CameraClsColor_ = dlAddress("CameraClsColor")
	CameraClsMode_ = dlAddress("CameraClsMode")
	CameraFogColor_ = dlAddress("CameraFogColor")
	CameraFogMode_ = dlAddress("CameraFogMode")
	CameraFogRange_ = dlAddress("CameraFogRange")
	CameraPick_ = dlAddress("CameraPick")
	CameraProject_ = dlAddress("CameraProject")
	CameraProjMode_ = dlAddress("CameraProjMode")
	CameraRange_ = dlAddress("CameraRange")
	CameraViewport_ = dlAddress("CameraViewport")
	CameraZoom_ = dlAddress("CameraZoom")
	ClearCollisions_ = dlAddress("ClearCollisions")
	ClearSurface_ = dlAddress("ClearSurface")
	ClearTextureFilters_ = dlAddress("ClearTextureFilters")
	ClearWorld_ = dlAddress("ClearWorld")
	CollisionEntity_ = dlAddress("CollisionEntity")
	Collisions_ = dlAddress("Collisions")
	CollisionNX_ = dlAddress("CollisionNX")
	CollisionNY_ = dlAddress("CollisionNY")
	CollisionNZ_ = dlAddress("CollisionNZ")
	CollisionSurface_ = dlAddress("CollisionSurface")
	CollisionTime_ = dlAddress("CollisionTime")
	CollisionTriangle_ = dlAddress("CollisionTriangle")
	CollisionX_ = dlAddress("CollisionX")
	CollisionY_ = dlAddress("CollisionY")
	CollisionZ_ = dlAddress("CollisionZ")
	CountChildren_ = dlAddress("CountChildren")
	CountCollisions_ = dlAddress("CountCollisions")
	CopyEntity_ = dlAddress("CopyEntity")
	CopyMesh_ = dlAddress("CopyMesh")
	CountSurfaces_ = dlAddress("CountSurfaces")
	CountTriangles_ = dlAddress("CountTriangles")
	CountVertices_ = dlAddress("CountVertices")
	CreateBlob_ = dlAddress("CreateBlob")
	CreateBrush_ = dlAddress("CreateBrush")
	CreateCamera_ = dlAddress("CreateCamera")
	CreateCone_ = dlAddress("CreateCone")
	CreateCylinder_ = dlAddress("CreateCylinder")
	CreateCube_ = dlAddress("CreateCube")
	CreateFluid_ = dlAddress("CreateFluid")
	CreateGeosphere_ = dlAddress("CreateGeosphere")
	CreateMesh_ = dlAddress("CreateMesh")
	CreateLight_ = dlAddress("CreateLight")
	CreatePivot_ = dlAddress("CreatePivot")
	CreatePlane_ = dlAddress("CreatePlane")
	CreateQuad_ = dlAddress("CreateQuad")
	CreateShadow_ = dlAddress("CreateShadow")
	CreateSphere_ = dlAddress("CreateSphere")
	CreateSprite_ = dlAddress("CreateSprite")
	CreateSurface_ = dlAddress("CreateSurface")
	CreateStencil_ = dlAddress("CreateStencil")
	CreateTerrain_ = dlAddress("CreateTerrain")
	CreateTexture_ = dlAddress("CreateTexture")
	CreateVoxelSprite_ = dlAddress("CreateVoxelSprite")
	DeltaPitch_ = dlAddress("DeltaPitch")
	DeltaYaw_ = dlAddress("DeltaYaw")
	EntityAlpha_ = dlAddress("EntityAlpha")
	EntityAutoFade_ = dlAddress("EntityAutoFade")
	EntityBlend_ = dlAddress("EntityBlend")
	EntityBox_ = dlAddress("EntityBox")
	EntityClass_ = dlAddress("EntityClass")
	EntityCollided_ = dlAddress("EntityCollided")
	EntityColor_ = dlAddress("EntityColor")
	EntityDistance_ = dlAddress("EntityDistance")
	EntityFX_ = dlAddress("EntityFX")
	EntityInView_ = dlAddress("EntityInView")
	EntityName_ = dlAddress("EntityName")
	EntityOrder_ = dlAddress("EntityOrder")
	EntityParent_ = dlAddress("EntityParent")
	EntityPick_ = dlAddress("EntityPick")
	EntityPickMode_ = dlAddress("EntityPickMode")
	EntityPitch_ = dlAddress("EntityPitch")
	EntityRadius_ = dlAddress("EntityRadius")
	EntityRoll_ = dlAddress("EntityRoll")
	EntityShininess_ = dlAddress("EntityShininess")
	EntityTexture_ = dlAddress("EntityTexture")
	EntityType_ = dlAddress("EntityType")
	EntityVisible_ = dlAddress("EntityVisible")
	EntityX_ = dlAddress("EntityX")
	EntityY_ = dlAddress("EntityY")
	EntityYaw_ = dlAddress("EntityYaw")
	EntityZ_ = dlAddress("EntityZ")
	ExtractAnimSeq_ = dlAddress("ExtractAnimSeq")
	FindChild_ = dlAddress("FindChild")
	FindSurface_ = dlAddress("FindSurface")
	FitMesh_ = dlAddress("FitMesh")
	FlipMesh_ = dlAddress("FlipMesh")
	FreeBrush_ = dlAddress("FreeBrush")
	FreeEntity_ = dlAddress("FreeEntity")
	FreeShadow_ = dlAddress("FreeShadow")
	FreeTexture_ = dlAddress("FreeTexture")
	GeosphereHeight_ = dlAddress("GeosphereHeight")
	GetBrushTexture_ = dlAddress("GetBrushTexture")
	GetChild_ = dlAddress("GetChild")
	GetEntityBrush_ = dlAddress("GetEntityBrush")
	GetEntityType_ = dlAddress("GetEntityType")
	GetMatElement_ = dlAddress("GetMatElement")
	GetParentEntity_ = dlAddress("GetParentEntity")
	GetSurface_ = dlAddress("GetSurface")
	GetSurfaceBrush_ = dlAddress("GetSurfaceBrush")
	Graphics3D_ = dlAddress("Graphics3D")
	HandleSprite_ = dlAddress("HandleSprite")
	HideEntity_ = dlAddress("HideEntity")
	LightColor_ = dlAddress("LightColor")
	LightConeAngles_ = dlAddress("LightConeAngles")
	LightRange_ = dlAddress("LightRange")
	LinePick_ = dlAddress("LinePick")
	LoadAnimMesh_ = dlAddress("LoadAnimMesh")
	LoadAnimTexture_ = dlAddress("LoadAnimTexture")
	LoadBrush_ = dlAddress("LoadBrush")
	LoadGeosphere_ = dlAddress("LoadGeosphere")
	LoadMesh_ = dlAddress("LoadMesh")
	LoadTerrain_ = dlAddress("LoadTerrain")
	LoadTexture_ = dlAddress("LoadTexture")
	LoadSprite_ = dlAddress("LoadSprite")
	MeshCSG_ = dlAddress("MeshCSG")
	MeshDepth_ = dlAddress("MeshDepth")
	MeshesIntersect_ = dlAddress("MeshesIntersect")
	MeshHeight_ = dlAddress("MeshHeight")
	MeshWidth_ = dlAddress("MeshWidth")
	ModifyGeosphere_ = dlAddress("ModifyGeosphere")
	ModifyTerrain_ = dlAddress("ModifyTerrain")
	MoveEntity_ = dlAddress("MoveEntity")
	NameEntity_ = dlAddress("NameEntity")
	PaintEntity_ = dlAddress("PaintEntity")
	PaintMesh_ = dlAddress("PaintMesh")
	PaintSurface_ = dlAddress("PaintSurface")
	PickedEntity_ = dlAddress("PickedEntity")
	PickedNX_ = dlAddress("PickedNX")
	PickedNY_ = dlAddress("PickedNY")
	PickedNZ_ = dlAddress("PickedNZ")
	PickedSurface_ = dlAddress("PickedSurface")
	PickedTime_ = dlAddress("PickedTime")
	PickedTriangle_ = dlAddress("PickedTriangle")
	PickedX_ = dlAddress("PickedX")
	PickedY_ = dlAddress("PickedY")
	PickedZ_ = dlAddress("PickedZ")
	PointEntity_ = dlAddress("PointEntity")
	PositionEntity_ = dlAddress("PositionEntity")
	PositionMesh_ = dlAddress("PositionMesh")
	PositionTexture_ = dlAddress("PositionTexture")
	ProjectedX_ = dlAddress("ProjectedX")
	ProjectedY_ = dlAddress("ProjectedY")
	ProjectedZ_ = dlAddress("ProjectedZ")
	RenderWorld_ = dlAddress("RenderWorld")
	RepeatMesh_ = dlAddress("RepeatMesh")
	ResetEntity_ = dlAddress("ResetEntity")
	RotateEntity_ = dlAddress("RotateEntity")
	RotateMesh_ = dlAddress("RotateMesh")
	RotateSprite_ = dlAddress("RotateSprite")
	RotateTexture_ = dlAddress("RotateTexture")
	ScaleEntity_ = dlAddress("ScaleEntity")
	ScaleMesh_ = dlAddress("ScaleMesh")
	ScaleSprite_ = dlAddress("ScaleSprite")
	ScaleTexture_ = dlAddress("ScaleTexture")
	SetAnimTime_ = dlAddress("SetAnimTime")
	SetCubeFace_ = dlAddress("SetCubeFace")
	SetCubeMode_ = dlAddress("SetCubeMode")
	ShowEntity_ = dlAddress("ShowEntity")
	SpriteRenderMode_ = dlAddress("SpriteRenderMode")
	SpriteViewMode_ = dlAddress("SpriteViewMode")
	StencilAlpha_ = dlAddress("StencilAlpha")
	StencilClsColor_ = dlAddress("StencilClsColor")
	StencilClsMode_ = dlAddress("StencilClsMode")
	StencilMesh_ = dlAddress("StencilMesh")
	StencilMode_ = dlAddress("StencilMode")
	TerrainHeight_ = dlAddress("TerrainHeight")
	TerrainX_ = dlAddress("TerrainX")
	TerrainY_ = dlAddress("TerrainY")
	TerrainZ_ = dlAddress("TerrainZ")
	TextureBlend_ = dlAddress("TextureBlend")
	TextureCoords_ = dlAddress("TextureCoords")
	TextureHeight_ = dlAddress("TextureHeight")
	TextureFilter_ = dlAddress("TextureFilter")
	TextureName_ = dlAddress("TextureName")
	TextureWidth_ = dlAddress("TextureWidth")
	TFormedX_ = dlAddress("TFormedX")
	TFormedY_ = dlAddress("TFormedY")
	TFormedZ_ = dlAddress("TFormedZ")
	TFormNormal_ = dlAddress("TFormNormal")
	TFormPoint_ = dlAddress("TFormPoint")
	TFormVector_ = dlAddress("TFormVector")
	TranslateEntity_ = dlAddress("TranslateEntity")
	TriangleVertex_ = dlAddress("TriangleVertex")
	TurnEntity_ = dlAddress("TurnEntity")
	UpdateNormals_ = dlAddress("UpdateNormals")
	UpdateTexCoords_ = dlAddress("UpdateTexCoords")
	UpdateWorld_ = dlAddress("UpdateWorld")
	UseStencil_ = dlAddress("UseStencil")
	VectorPitch_ = dlAddress("VectorPitch")
	VectorYaw_ = dlAddress("VectorYaw")
	VertexAlpha_ = dlAddress("VertexAlpha")
	VertexBlue_ = dlAddress("VertexBlue")
	VertexColor_ = dlAddress("VertexColor")
	VertexCoords_ = dlAddress("VertexCoords")
	VertexGreen_ = dlAddress("VertexGreen")
	VertexNormal_ = dlAddress("VertexNormal")
	VertexNX_ = dlAddress("VertexNX")
	VertexNY_ = dlAddress("VertexNY")
	VertexNZ_ = dlAddress("VertexNZ")
	VertexRed_ = dlAddress("VertexRed")
	VertexTexCoords_ = dlAddress("VertexTexCoords")
	VertexU_ = dlAddress("VertexU")
	VertexV_ = dlAddress("VertexV")
	VertexW_ = dlAddress("VertexW")
	VertexX_ = dlAddress("VertexX")
	VertexY_ = dlAddress("VertexY")
	VertexZ_ = dlAddress("VertexZ")
	VoxelSpriteMaterial_ = dlAddress("VoxelSpriteMaterial")
	Wireframe_ = dlAddress("Wireframe")
	' ***extras***
	EntityScaleX_ = dlAddress("EntityScaleX")
	EntityScaleY_ = dlAddress("EntityScaleY")
	EntityScaleZ_ = dlAddress("EntityScaleZ")
	LoadShader_ = dlAddress("LoadShader")
	CreateShader_ = dlAddress("CreateShader")
	ShadeSurface_ = dlAddress("ShadeSurface")
	ShadeMesh_ = dlAddress("ShadeMesh")
	ShadeEntity_ = dlAddress("ShadeEntity")
	ShaderTexture_ = dlAddress("ShaderTexture")
	SetFloat_ = dlAddress("SetFloat")
	SetFloat2_ = dlAddress("SetFloat2")
	SetFloat3_ = dlAddress("SetFloat3")
	SetFloat4_ = dlAddress("SetFloat4")
	UseFloat_ = dlAddress("UseFloat")
	UseFloat2_ = dlAddress("UseFloat2")
	UseFloat3_ = dlAddress("UseFloat3")
	UseFloat4_ = dlAddress("UseFloat4")
	SetInteger_ = dlAddress("SetInteger")
	SetInteger2_ = dlAddress("SetInteger2")
	SetInteger3_ = dlAddress("SetInteger3")
	SetInteger4_ = dlAddress("SetInteger4")
	UseInteger_ = dlAddress("UseInteger")
	UseInteger2_ = dlAddress("UseInteger2")
	UseInteger3_ = dlAddress("UseInteger3")
	UseInteger4_ = dlAddress("UseInteger4")
	UseSurface_ = dlAddress("UseSurface")
	UseMatrix_ = dlAddress("UseMatrix")
	LoadMaterial_ = dlAddress("LoadMaterial")
	ShaderMaterial_ = dlAddress("ShaderMaterial")
	CreateOcTree_ = dlAddress("CreateOcTree")
	OctreeBlock_ = dlAddress("OctreeBlock")
	OctreeMesh_ = dlAddress("OctreeMesh")
	
End Function

' Blitz2D functions
' -----------------

Rem
bbdoc: Begin using Max2D functions.
End Rem
Function BeginMax2D()

	' Function by Oddball
	glPopClientAttrib()
	glPopAttrib()
	glMatrixMode(GL_MODELVIEW)
	glPopMatrix()
	glMatrixMode(GL_PROJECTION)
	glPopMatrix()
	glMatrixMode(GL_TEXTURE)
	glPopMatrix()
	glMatrixMode(GL_COLOR)
	glPopMatrix()
	
End Function

Rem
bbdoc: End using Max2D functions.
End Rem
Function EndMax2D()

	' save the Max2D settings for later - Function by Oddball
	glPushAttrib(GL_ALL_ATTRIB_BITS)
	glPushClientAttrib(GL_CLIENT_ALL_ATTRIB_BITS)
	glMatrixMode(GL_MODELVIEW)
	glPushMatrix()
	glMatrixMode(GL_PROJECTION)
	glPushMatrix()
	glMatrixMode(GL_TEXTURE)
	glPushMatrix()
	glMatrixMode(GL_COLOR)
	glPushMatrix()
	
	TGlobal.EnableStates()
	glDisable(GL_TEXTURE_2D) ' needed as Draw in Max2d enables it, but doesn't disable after use
	
	SetRenderState(TGlobal.ALPHA_ENABLE,0) ' alpha blending was disabled by Max2d
	SetRenderState(TGlobal.FX1,0) ' normals was enabled (full bright/no shading)
	SetRenderState(TGlobal.FX2,1) ' vertex colors was enabled
	
	glLightModeli(GL_LIGHT_MODEL_COLOR_CONTROL,GL_SEPARATE_SPECULAR_COLOR)
	glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER,GL_TRUE)
	
	glClearDepth(1.0)						
	glDepthFunc(GL_LEQUAL)
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)

	glAlphaFunc(GL_GEQUAL,0.5)
	
End Function

' Includes
' --------

Include "types.bmx"
Include "functions.bmx"

OpenLibrary()
