//
//  MovieDetailsViewController.swift
//  assignment1
//
//  Created by OrcunTasdemir on 11/29/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    
    @IBAction func posterTapAction(_ sender: UITapGestureRecognizer) {
        print("poster tapped!")
    }
    
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    //look up swift optionals
    var movie: [String:Any]!
    var getVideos = [[String: Any]]()
    var trailerUrl: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieId = movie["id"] as! Int
        let movieIdS = String(movieId)
        let urlBegin = "https://api.themoviedb.org/3/movie/"
        let urlEnd = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let url = URL(string: urlBegin + movieIdS + urlEnd)!
        print("url: ", url)
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 self.getVideos = dataDictionary["results"] as! [[String:Any]]
                 print(getVideos)
             }
        }
        task.resume()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let baseUrlforBackDrop = "https://image.tmdb.org/t/p/w780"
        
        let backDropPath = movie["backdrop_path"] as! String
        
        let backDropUrl = URL(string: baseUrlforBackDrop + backDropPath)
        
        backdropView.af.setImage(withURL: backDropUrl!)
    }
    

    
    //     MARK: - Navigation

    //     In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //Get the new view controller using segue.destination.
            //Pass the selected object to the new view controller.
            print("Loading up the trailers screen!")
            
            var i = 0
            var length = getVideos.count
            while(length >= 0){
                if(getVideos[i]["type"] as! String == "Trailer"){
                    break
                }
                else if(length == 0){
                    i = 0
                    break
                }
                else
                {
                    i = i + 1
                }
                length = length - 1
            }
            
            let getVideo = getVideos[i]
            print("this is i: ", i)
            print("get video: ", getVideo)
            let key = getVideo["key"] as! String
            print("key: ", key)
            let youtubeUrl = "https://www.youtube.com/watch?v="

            trailerUrl = URL(string: youtubeUrl + key)
            print(trailerUrl)

            let trailerViewController = segue.destination as! TrailerViewController
            trailerViewController.trailerUrl = trailerUrl
            print("passing it here: ", trailerUrl)
            
    }
}
